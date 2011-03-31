---
layout: rosella
title: Rosella Test
---

## Overview

The Rosella Test library implements a series of utilities for implenting a
suite of unit tests. By default, the Test library is configured to output
TAP to the console, although other mechanisms of reporting results can be
substituted.

## Concepts

### Method Extraction

The basic method of executing a sequence of tests is to use the
`Rosella.Test.test()` function. This function sets up all the necessary
objects, creates the testing environment, executes the tests, and reports
the results to the user.

The one required argument to this function is a type object for the test. The
type class must contain a sequence of test methods. Every method in the type
is considered to be a test.

During Suite construction, all method objects are extracted from the target
type, and each one is wrapped in a TestCase object. This extraction happens
through method calls on the Parrot Class PMC associated with that type. A test
type which overrides VTABLE_find_method will not be able to use that mechanism
to override or dynamically generate the list of test methods to execute.

Currently no other mechanism exists to manually specify a list of methods to
execute as tests. Such a mechanism is planned to be added in later versions of
Rosella Test.

### Method Execution

Method objects are extracted from the target type. During Suite execution,
each method is invoked on a TestCase object instead of the type where it was
defined. This is an important distinction to make. Because of this insulation,
a test method during execution does not have:

* Access to any attributes of the target type, or attributes inherited by the
target type from its parents
* Access to any other test methods or other methods in the target type.

Because of this mechanism if you need to have access to shared data, or helper
methods, those should be added to the TestContext object prior to test
execution.

## Namespaces

### Test

The `Rosella.Test` namespace contains the `test` function, which is a facade
over some of the more complex and configurable portions of the library. For
most general-case usages, use the `test` function to execute a test class.

Most test files will start with something similar to the following preamble:

    Rosella::Test::test(My::Test::Class);
    class My::Test::Class {
        ...
    }

The first argument to the `test` function is the type from which to extract
methods. This is the only required parameter. There are a number of optional
named parameters which can be provided to change certain aspects of the
library.

* `context`: The object to use as the TestContext for the tests. This value
   will be available in the `context` or `$!context` attributes from inside
   the running test. If this parameter is not provided, this will be an
   instance of `Rosella.Test.TestContext`.
* `testcase_type`: The type of object to use for each individual test. By
  default this will be `Rosella.Test.TestCase`. This can be changed,
  although it is not recommended for most usages. If you do need to make
  something different, you should use a subclass of TestCase (not an arbitrary
  stand-in) and should read the special notes about TestCase and its
  peculiarities.
* `suite_type`: You can specify a different type of object to use as the
  Suite. By default this is `Rosella.Test.Suite`. Suites control the running
  of tests. A common reason to provide a custom subclass of Suite would be
  to introduce a specific test ordering (or shuffling).

### Assert

The `Assert` namespace (NOT `Rosella.Assert`) namespace contains a number of
functions for performing assertions and verifications within a test. For
brevity this namespace is not located under the `Rosella` namespace.
Mechanisms may be provided to relocate these routines if there are conflicts
with user-defined namespaces.

## Public Classes

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
create Suites.

### Test.SuiteFactory

`Rosella.Test.SuiteFactory` is used to create Suite objects and load them with
a collection of TestCase objects and a TestContext

### Test.TestCase

A TestCase object is an insulated execution environment for a test method.
Methods are extracted from the target type and are executed on TestCase
objects.

TestCase uses a special system for attributes. This is because TestCase is
intended to be used from languages with different requirements with respect
to attribute use and naming conventions. For instance, In NQP or Perl6 it
would be customary to refer to an attribute with a sigil, such as `$!context`.
In Winxed or other similar languages, the sigil is not required (and in some
cases, not permitted).

Also, attributes in TestCase should not be modified. The context attribute
holds important information about the test run, and holds data which can be
used by other tests in the sequence. This attribute should not be modified nor
overwritten during test execution. Because of this requirement, attributes in
TestCase are read-only.

This mechanism is implemented by having an attribute internally called
`test_context`. TestCase intercepts `set_attr_str` vtable calls at the Parrot
level and throws an exception. It also intercepts `get_attr_str` vtable calls
and translates attribute names in a language-agnostic way. Attribute accesses
to "`$!context`" and "`context`" are both translated to an access for
"`test_context`". Subclasses of TestCase will inherit this behavior and will
need to design their interfaces accordingly. `Rosella.Test.TestFactory` uses
an internal mechanism for setting these attributes to default values without
running afoul of the prohibition on writing values to attributes.

The context object is used to provide a shared data context between tests, so
that tests can access the same data. The `status` attribute contains a
`Rosella.Test.TestStatus` object, which is used to control the execution of
the test and communicates information about its status back to the Suite. The
TestContext can and, for all but the most trivial uses, be replaced or
subclassed as necessary. The TestStatus object cannot be.

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
        Assert::equal(0, 1);
    }

    method test_verify() {
        $!status.verify("Basic Sanity Test (BST)");
        Assert::equal(1, 1);
    }

    method test_set_data() {
        $!context.set_data("Number", 7);
    }

    method test_get_data() {
        my $value := $!context.get_data("Number");
        Assert::equal($value, 7);
    }

### Test.TestContext

Every test run contains a single `Rosella.Test.TestContext` object which is
shared among all TestCase objects in the Suite. TestContext is used to
provide behaviors and persistant data to tests in the Suite which are not
available in an insulated TestCase environment.

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
cannot be modified, subclassed, or replaced.

## Private Classes

### Test.Failure

`Rosella.Test.Failure` is a helper class to distinguish an Exception object
between special Failure and normal exception types. A Failure Exception is
a special condition which indicates the failure (perhaps the expected failure)
of an assertion. Other exceptions indicate a different type of runtime error,
one which is likely not planned by the test.

### Test.Result

`Rosella.Test.Result` is used by the Suite to keep track of the status of the
test, and to communicate results to an array of Listener objects. By default
a Result is created with a single TAP listner, although this is configurable.

## Examples

### Winxed

### NQP-rx

## Users

* Rosella uses the Test library to implement its own unit tests
* [Parrot-Linear-Algebra](http://github.com/Whiteknight/parrot-linear-algebra)
uses the Test library for unit tests
