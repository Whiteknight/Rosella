---
layout: rosella
title: Rosella Test
---

## Overview

The Rosella Test library implements a series of utilities for implementing a
suite of unit tests. By default, the Test library is configured to output
TAP to the console, although other mechanisms of reporting results can be
substituted.

## Concepts

### Method Extraction

The basic method of executing a sequence of test methods from a test class
is to use the `Rosella.Test.test()` function. This function sets up all the
necessary objects, creates the testing environment, executes the tests, and
reports the results to the user.

The one required argument to this function is a type object for the test. The
type class must contain a sequence of test methods. By default every method in
the type is considered to be a test, unless rules are added to limit the
selection.

During Suite construction, all method objects are extracted from the target
type, and each one is wrapped in a TestCase object. This extraction happens
through method calls on the Parrot Class PMC associated with that type. A test
type which overrides the `find_method` VTABLE will not be able to use that
mechanism to override or dynamically generate the list of test methods to
execute, because method extraction goes through the Class directly instead of
through the object and its overrides.

### Test Methods and Test Functions

`Rosella.Test.test` extracts methods from a user-defined test class and
executes each as a separate *test method*. `Rosella.Test.test_vector` takes
a single function and executes it over each item in a data array. In the case
of `test`, the test methods should be defined as methods because they are
executed as methods. Test methods defined like this should take no parameters
and should return no results here are some right/wrong examples in NQP:

    method my_test() { ... }            # Right way in NQP
    sub my_test() { ... }               # WRONG! Not a method
    method my_test($x) { ... }          # WRONG! Should not take parameters
    method my_test($x) { return 1; }    # WRONG! Return values are ignored

Functions for `test_vector` are also invoked as methods on TestCase. They take
a single parameter, the data item to test with. Here are some right/wrong
examples in NQP:

    method my_test($data) { ... }       # Right way in NQP
    sub my_test($self, $data) { ... }   # Equivalent
    method my_test($s, $data) { ... }   # WRONG! Too many parameters
    sub my_test($data) { ... }          # WRONG! No invocant
    sub my_test() { ... }               # WRONG! No invocant and no parameter
    method my_test() { ... }            # WRONG! No parameter

### Test Method Execution

During Suite execution each test method is invoked on a TestCase object
instead of an object of the type where it was defined. This is an important
distinction to make. Because of this insulation, a test method during
execution does not have:

* Access to any attributes from the test class or attributes inherited by the
test class from its parents
* Access to any other test methods or other methods in the test class.
* Access to any vtable overrides defined in the test class.

Because of this mechanism if you need to have access to shared data, or helper
methods, those should be added to the TestContext object prior to test
execution.

Each test method executes in almost complete isolation from other aspects of
the test environment. The only shared piece of data is the TestContext object.
Here are some examples of things you cannot use:

    class My::Test::Class is My::Test::Parent   # 1
    {
        has $!data;     #2

        method test_foo() {
            $self.test_bar();   #3
            my $d := $!data;    #4
        }
    }

1. Test methods will be extracted from the type, including test methods
   declared in parent types. However, attributes and vtable overrides and
   other things defined in the parent class will be ignored.
2. You do not have access to attributes defined in the test class during test
   execution. Don't bother trying to add them.
3. Each test method is individiually invoked on a fresh TestCase object, and
   does not have access to any other methods on `$self`. Notice that during
   test execution, `$self` is an object of type `Rosella.Test.TestCase`, not
   `My::Test::Class`.
4. You cannot use attributes from `My::Test::Class`, because `$self` is a
   `TestCase` object.

This aspect of test execution, the complete isolation of test methods during
execution, is the most problematic and confusing aspect of testing with
Rosella Test. This is because Rosella extracts the methods from the class you
define and executes them in a different context. This semantic change is
completely different from how methods and classes typically act in NQP or
Winxed code. Pay close attention to this aspect when you are writing tests.

### Test Success and Failure

Test methods execute and are marked either as having passed or failed. A
failure is when the test prematurely exits due to an unhandled exception or a
failed assertion. Success is any other result. An empty test passes, because
it does not prematurely exit:

    method easy_test() { }

When a test fails, the error message from the unhandled exception or failed
assertion will be printed along with a backtrace. The backtrace may omit data
not relevant to the user of the tests (such as backtrace information internal
to Rosella). This should tell you where the failure was and what failure
condition caused it.

## Namespaces

### Test

The `Rosella.Test` namespace contains the `test` and `test_vector` functions,
which are facades over some of the more complex and configurable portions of
the library. For most general-case usages, use the `test` or `test_vector`
functions to execute a test class or a test array, respectively.

Most test files will start with something similar to the following preamble:

    Rosella::Test::test(My::Test::Class);
    class My::Test::Class {
        ...
    }

The code is slightly more verbose in Winxed:

    using Rosella.Test.test;
    test(class MyTestClass);

    class MyTestClass {
        ...
    }

This setup is used to execute a *test class*. A test class is a class where
all the methods are treated as independent tests, and executed sequentially.
The first argument to the `test` function is the type from which to extract
methods. This is the only required parameter. There are a number of optional
named parameters which can be provided to change certain aspects of the
library.

* `context`: The object to use as the TestContext for the tests. This value
  will be available in the `context` or `$!context` attributes from inside
  the running test. If this parameter is not provided, tthe default is a fresh
  instance of `Rosella.Test.TestContext`.
* `testcase_type`: The type of object to use for each individual test. By
  default this will be `Rosella.Test.TestCase`. This can be changed,
  although it is not recommended for most usages. If you do need to make
  something different, you should use a subclass of TestCase (not an arbitrary
  stand-in) and should read the special notes about TestCase and its
  peculiarities further down in this file and also in the TestCase source.
* `suite_type`: You can specify a different type of object to use as the
  Suite. By default this is `Rosella.Test.Suite`. Suites control the running
  of tests. A common reason to provide a custom subclass of Suite would be
  to introduce a specific test ordering (or shuffling). Rosella uses custom
  subclasses of Suite to test the Test library itself (such as inserting a
  mock object Suite instead of a real one).
* `asserter`: The object which provides conditionals and assertions. By
  default this is a `Rosella.Test.Asserter` object, although you can replace
  this  with an object of a custom type or a subclass. Notice that if you
  remove certain functionality from the asserter, you won't be able to use a
  full range of conditionals and assertions in your tests.
* `test_prefix`: The prefix string that identifies test methods. By default
  the prefix is empty and all methods are tests. If you add a prefix, methods
  without the prefix will be ignored (and will not be available for use in
  the test).

Another way to use the library is with the `test_vector` function.
`test_vector` is used to execute a series of repetitive tests over a
collection of data. `test_vector` executes a single test method on every item
in an array or hash. Here's how to set up a test sequence with `test_vector`,
in NQP:

    Rosella::Test::test_vector(method($item) {
        # Test logic goes here
    }, [
        # Data items go here
    ]);

For instance, if we want to test out a repetitive sequence of arithmetic
operations, we could do something like this:

    Rosella::Test::test_vector(method(@items) {
        $!assert.equal(@items[0] + @items[1], @items[2]);
    }, [
        [1, 2, 3],
        [3, 4, 7],
        [10, 20, 30]
    ]);

Similarly, you can use a hash to give names to each test. This example is in
Winxed:

    function main[main]() {
        using tester;
        using Rosella.Test.test_vector;
        test_vector(function (obj, data) {
            obj.assert.equal(data[0] + data[1], data[2]);
        }, {
            "1 + 2 = 3" : [1, 2, 3],
            "3 + 4 = 7" : [3, 4, 7],
            "10 + 20 = 30" : [10, 20, 30]
        });
    }

The `test` function executes multiple test methods over a single bit of common
data (the TestContext). The `test_vector` function executes a single test
method over an array of data.

## Public Classes

### Test.Asserter

`Rosella.Test.Asserter` is the mechanism you use from inside your tests to
check conditions and assert various things. From a running test method, the
Asserter is available in the `assert` or `$!assert` attribute.

You can override the default Asserter type and provide your own object or your
own custom subclass by passing in the "asserter" option to the
`Rosella.Test.test` function. In NQP:

    Rosella::Test::test(My::Test::Class, :asserter($myAsserter));

Whatever you pass as the "asserter" argument will be passed directly to the
`assert` (`$!assert`) attribute of the TestCase object. If you create a custom
subclass which either overrides any of the default methods or avoids them
entirely, your tests will not be able to use the features discussed below.

Here are some examples of common assertions in NQP. Winxed examples are
similar

    $!assert.fail("whoops!");        # Unconditional failure
    $!assert.equal("A", "A");        # Test for equality
    $!assert.not_equal("A", "B");
    $!assert.is_null($foo);          # Assert that the value is null
    $!assert.not_null($foo);
    $!assert.is_true($foo);          # Test for boolean truth.
    $!assert.is_false($foo);
    $!assert.defined($foo);          # Test that it is not Undef
    $!assert.not_defined($foo);
    $!assert.output_is({
        pir::say("Test!");
    }, "Test!\n");                  # Collect and test console output
    $!assert.throws({
        pir::die("Whoopsies!");
    })                              # Prove that we throw an exception
    $!assert.throws_nothing({
        say("No problem!");
    });

There are some assertions which are used to prove the value of the test. These
are meta-assertions, and are used primarily to prove the correct behavior of
test infrastructure. If you are writing your own test infrastructure, or your
own extensions to the Rosella test system, these tests can help to provide a
little bit of sanity. These can also be combined with other tests to invert
sequences of assertions, or used internally by new assertions to prove the
inverse of an existing assertion.

    $!assert.expect_pass({
        $!assert.equal(0, 0);
    });                             # Expect the test to pass. This is default.
    $!assert.expect_fail({
        $!assert.not_equal(0, 0);
    });                             # Expect failure. Can invert other assertions.

This is not a comprehensive list of all available assertions, and the list can
be easily expanded at any time to include new functionality. Also, Asserter
can be subclassed and the subclass used during tests instead, to add custom
functionality.

### Test.Builder

`Rosella.Test.Builder` is a partial reimplementation of Test::Builder from the
Parrot standard library. It is intended to be more usable and flexible than
Test::Builder is, and currently only contains the routines necessary to output
the results of the Test library.

Builder is the TAP outputter part of the library. It is responsible for
generating proper TAP output. It contains standard functions such as `ok`,
`todo`, and `diag` which are used by the test library to generate correct TAP
output.

In the normal sequence, Builder is invoked from `Test.Listener.TAP`. This
sequence may change in the future.

Builder can be used similarly to how `Test::Builder` works in the Parrot
repo, except it is object/method based and not just a list of subroutines
available in the current namespace.

    using Rosella.build;
    var test_builder = build(Rosella.Test.Builder);
    test_builder.plan(2);
    test_builder.ok(1, "The test is ok");
    test_builder.todo(0, "Whoopsie! It's okay, it's marked TODO");
    test_builder.diag("This is an error message");

At the moment test_builder provides only a small subset of the utility and
test functions provided by `Test::Builder`. More things could be added if
there is a demand by users to have this available as a complete substitute
for `Test::Builder`.

### Test.Listener

This is an empty parent class which implements the Listener interface.
Any number of Listener objects can be inserted into `Rosella.Test.Result` to
broadcast results to a number of possible receivers.

This class should not be used directly. You should subclass this class to get
interesting or custom behaviors. In the future, this class may be merged with
`Rosella.Test.Listener.TAP` since that is the primary and most commonly used
default implementation.

### Test.Listener.TAP

`Rosella.Test.Listener.TAP` is a bridge between `Rosella.Test.Result` to
`Rosella.Test.Builder`. The TAP Listener is used to generate TAP output for
the running test. TAP output will only be generated if this Listener is used,
which is the default.

### Test.Suite

A `Rosella.Test.Suite` is a collection of TestCase objects. The Suite runs
the TestCase objects in a loop, keeping track of the TestContext for all
tests, and feeding the results of each test to the Result object.

Suites should not be created directly. Use `Rosella.Test.SuiteFactory` to
create Suites. You can use a custom Suite object or subclass for particular
purposes, although the benefit of this is often outweighed by the complexity.
Suites typically can be used as is and modifications can be made to the
various objects the Suite manages.

### Test.SuiteFactory

`Rosella.Test.SuiteFactory` is used to create Suite objects and load them with
a collection of TestCase objects and a TestContext. This is called from
`Rosella.Test.test`.

### Test.SuiteFactory.Vector

`Rosella.Test.SuiteFactory.Vector` is used to build a Suite object for
vectorized tests. This is called from `Rosella.Test.test_vector`.

### Test.TestCase

A TestCase object is an insulated execution environment for a test method.
Methods are extracted from the target type and are executed on TestCase
objects as described above.

TestCase uses a special system for attributes. This is because TestCase is
intended to be used from languages with different requirements with respect
to attribute use and naming conventions. For instance, In NQP or Perl6 it
would be customary to refer to an attribute with a sigil, such as `$!context`.
In Winxed or other similar languages, the sigil is not required (and in some
cases, not permitted).

Also, attributes in TestCase should not be modified. Some attributes on
TestCase hold important status information necessary for the test run. Because
of this requirement, along with the indirection to support different language
semantics, attributes in TestCase are read-only.

This mechanism is implemented by having an attribute internally called
`test_context`. TestCase intercepts `set_attr_str` vtable calls at the Parrot
level and throws an exception for attempting to modify a read-only attribute.
It also intercepts `get_attr_str` vtable calls and translates attribute names
in a language-agnostic way. Attribute accesses to "`$!context`" and
"`context`" are both translated to an access for "`test_context`". Subclasses
of TestCase will inherit this behavior (unless specifically overriden) and
will need to design their interfaces accordingly. `Rosella.Test.TestFactory`
uses an internal mechanism for setting these attributes to default values
without running afoul of the prohibition on writing values to attributes.

The context object is used to provide a shared data context between tests, so
that tests can access shared data. The `status` attribute contains a
`Rosella.Test.TestStatus` object, which is used to control the execution of
the test and communicates information about its status back to the Suite. The
TestContext can and, for all but the most trivial uses, be replaced or
subclassed as necessary. The TestStatus object cannot be subclassed or
replaced, and should not be modified in any way.

In addition to the `test_context` attribute, the default TestCase type
provides a `test_method` attribute ("`$!method`" / "`method`") for accessing
the actual method object being invoked for the test. This is used internally
by the test system and probably has limited utility from inside a running
Test.

TestCase objects are difficult to work with because of the special insulation
which they have been designed with. In order to create and initialize a
TestCase object you must use a TestFactory.

Here are some examples of test methods written in NQP using these features:

    method test_empty() {
        # Empty body, passes by default
    }

    method test_unimplemented() {
        $!status.unimplemented("This test has no logic! Fix this");
    }

    method test_todo() {
        $!status.todo("Something is wrong here...");
        $!assert.equal(0, 1);
    }

    method test_verify() {
        $!status.verify("Basic Sanity Test (BST)");
        $!assert.equal(1, 1);
    }

    method test_set_data() {
        $!context.set_data("Number", 7);
    }

    method test_get_data() {
        my $value := $!context.get_data("Number");
        $!assert.equal($value, 7);
    }

### Test.TestContext

Every test run contains a single `Rosella.Test.TestContext` object which is
shared among all TestCase objects in the Suite. TestContext is used to
provide behaviors and persistant data to tests in the Suite which are not
available in an insulated TestCase environment.

TestContext provides a hash-like interface for storing and retreiving named
shared data items. To provide additional functionality, such as methods or
anything else, you can subclass TestContext or even replace it completely with
an object of your own choosing. There is no particular interface on
TestContext which the Test library relies on.

As described above, the TestContext object is provided in the "`context`"
attribute ("`$!context`", in NQP) of the TestCase.

### Test.TestFactory

`Rosella.Test.TestFactory` is used, primarily by the SuiteFactory, to create
TestCase objects for the Suite. TestFactory uses internal mechanisms to write
data to the TestCase attributes which are normally read-only.

The same mechanism could be used from within a running test to overwrite
values in the TestCase attributes. This is strongly *not recommended*, and
may create problems within the running test Suite, and will certainly run
afoul of future changes and refactors in this library. Don't do it. If you
really need to store data you can do so in the TestContext instead.

### Test.TestStatus

Every TestCase object has a `Rosella.Test.TestStatus` object. The TestStatus
object is used to control the test, provide information about the test to the
Suite, and contain information about result status which is communicated to
the Result object. Every TestCase has a TestStatus available. This class
cannot be modified, subclassed, or replaced. TestStatus provides a number of
methods which may be useful to people writing tests:


    # Mark the test TODO with the given explanation
    $!status.todo("message");

    # Set the display name of the test that is reported to the console
    $!status.verify("name");

    # Mark the test unimplemented. This is a combination of TODO and immediate
    # fail
    $!status.uinimplemented("msg");

    # Add a cleanup routine to execute after the completes, pass or fail.
    $!$status.add_cleanup_routine({ ... });

## Private Classes

### Test.Failure

`Rosella.Test.Failure` is a helper class to distinguish an Exception object
between an assertion Failure and normal unhandled exception types. A Failure
Exception is a special condition which indicates the failure (perhaps the
expected failure) of an assertion. Other exceptions indicate a different type
of runtime error, one which is likely not planned by the test. Mechanisms like
`$!assert.throws_nothing({})` will convert a thrown exception into a Failure.

### Test.Result

`Rosella.Test.Result` is used by the Suite to keep track of the status of the
test, and to communicate results to an array of Listener objects. By default
a Result is created with a single TAP-producing listener.

## Examples

### Winxed

Here is a complete example of class-based testing in Winxed:

    function main[main]() {
        load_bytecode("rosella/test.pbc");
        using Rosella.Test.test;
        test(class MyTestClass);
    }

    class MyTestClass {
        # Empty test passes
        function first_test() {
        }

        # Simple test with custom display name
        function second_test() {
            self.status.verify("Basic equality, sanity");
            self.assert.equal(1, 1);
        }

        # More advanced test with cleanup
        function third_test() {
            var f = new 'FileHandle'
            f.open("foo.pl", "r");
            self.status.add_cleanup_routine(function() {
                f.close();
            });
            self.status.verify("Can read a file");
            self.assert.equal(f.readline(), "#!/usr/bin/perl");
        }

        # Test to capture output to stdout and verify it.
        function fourth_test() {
            self.assert.output_is(function() {
                say("Hello world!");
            }, "Hello world!");
        }
    }

Here are is an example with `test_vector`:

    function main[main]() {
        // Simple test that items are equal
        using Rosella.Test.test_vector;
        test_vector(function(var self, var data) {
            self.assert.equal(data[0], data[1]);
        }, [
            [1, 1],     # Pass
            [2, 2],     # Pass
            [3, 4]      # Fail
        ]);
    }

And here is a more advanced test for `test_vector`. Hashes can be used to
give each item in the test a name:

    // Test expected values of an equation y = mx + b
    using Rosella.Test.test_vector;
    test_vector(function(var self, var data) {
        int y = (data[0] * data[1]) + data[2];
        self.assert.equal(y, data[3]);
    }, {
        "Sanity" : [0, 0, 0, 0],              # Pass
        "Passing example" : [1, 5, 2, 7],     # Pass
        "Failing example" : [3, 4, -10, 4]    # Fail (3 * 4 - 10 = 2, not 4)
    });

### NQP-rx

## Users

* Rosella uses the Test library to implement its own unit tests
* [Parrot-Linear-Algebra](http://github.com/Whiteknight/parrot-linear-algebra)
uses the Test library for unit tests
