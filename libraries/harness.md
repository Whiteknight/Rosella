---
layout: rosella
title: Rosella Harness
---

## Overview

The Harness library provides utilities necessary to create a custom test
harness for a test suite.

## Concepts

Test suites are broken up into two components: The tests themselves and the
test harness. The two components communicate together through some kind of
interchange library, which is TAP by default. Other formats are not currently
supported, although a mechanism for using custom parsers will be provided in
later releases of this library.

### TAP

Tests are called "TAP Producers" because they generate an output stream of TAP
to indicate result information. The harness is called a "TAP Consumer",
because it reads the stream of TAP data, parses it, and displays condensed
result information to the user.

Rosella provides a TAP producer library, the Rosella Test library. However,
the Harness library should be able to work with any TAP producer.

### MVC

The Harness library follows an MVC architecture. In MVC there are three basic
components: The Model which contains data and logic for the program to use,
the View which displays information to the user, and the Controller which
controls the running of the program and passes data from the Model to the
View.

## Namespaces

None.

## Public Classes

### Harness

The Harness class is the Controller portion of the library. It is responsible
for taking in a TestRun object or a sequence of them, and executing all tests
therein.

    my $harness := Rosella::build(Rosella::Harness);

### Harness.TestFile

A `Rosella.Harness.TestFile` object represents a single file in a test suite.
The test file contains zero or more individual tests. In general, TestFile
should not be used directly, it should be used instead with one of various
subclasses for specific types of file.

TestFile objects should be created using the
`Rosella.Harness.TestFile.Factory` class. Do not try to create them directly.

### Harness.TestFile.Custom

A Custom TestFile is one where the user can specify the details of how to
compile and execute the file.

    my $factory := Rosella::build(Rosella::Harness::TestFile::Factory,
        Rosella::Harness::TestFile::Custom
    );
    my $testfile := $factory.create("t/foo/whatever.t");

### Harness.TestFile.Factory

`Rosella.Harness.TestFile.Factory` is an ObjectFactory for creating Testfile
objects. In addition to the basic ObjectFactory interface, it provides a
series of helper methods to return an array of TestFile objects from a list of
file names or a directory which contains files.

    my $factory := Rosella::build(Rosella::Harness::TestFile::Factory,
        Rosella::Harness::TestFile::PIR
    );
    my $testfile := $factory.create("t/whatever.t");
    my @files := $factory.create_tests_from_files([
        "t/foo.t", "t/bar.t", "t/baz.t"
    ]);
    my @dirfiles := $factory.create_tests_from_dirs([
        "t/sanity", "t/pmc", "t/src"
    ]);

### Harness.TestFile.NQP

A TestFile type for executing tests written in NQP.

### Harness.TestFile.PIR

A TestFile type for executing tests written in PIR.

### Harness.TestFile.Winxed

A TestFile type for executing tests written in Winxed. Notice that you must
have Winxed installed for this to work.

### Harness.TestRun

A `Rosella.Harness.TestRun` object is an ordered list of tests, and is the
Model portion of the MVC architecture. The TestRun keeps track of the list of
TestFile objects, and keeps track of their results after the tests have been
executed. TestRun includes a few query methods to get counts and lists of
TestFile objects based on completion status.

TestRun objects should not be created directly, but instead should be created
using the `Rosella.Harness.TestRun.Factory` object.

### Harness.TestRun.Factory

A `Rosella.Harness.TestRun.Factory` object creates TestRun objects, populating
them with lists of TestFile objects retrieved from lists of files or
directories.

### Harness.View

The `Rosella.Harness.View` object is used to display running status and result
information to the user. The default View object displays the status and
result information on the command-line in a manner similar to standard TAP
harnesses from the world of Perl. The interface for View is simplistic, and
can be easily subclassed or replaced entirely to get new behavior.

## Private Classes

### Harness.TestFile.Line

This class is an implementation detail of the TAP parser and will be going
away in the next round of refactors. Do not use this class or rely on it for
any reason.

### Harness.TestRun.ResultSet

This is an internal class to help organize tests and test files by result.

## Examples

### Winxed

Here is a minimal harness written in Winxed:

    function main[main]() {
        load_bytecode("rosella/harness.pbc");
        var factory = new Rosella.Harness.TestRun.Factory();
        var harness = new Rosella.Harness();
        var view = harness.default_view();
        factory.add_test_dirs("Winxed", "t", 1:[named("recurse")]);
        var testrun = factory.create();
        view.add_run(testrun);
        harness.run(testrun, view);
        view.show_results();
    }

Here is a version of the harness which takes a list of test directories from
the command line:

    function main[main](var args) {
        load_bytecode("rosella/harness.pbc");
        var factory = new Rosella.Harness.TestRun.Factory();
        var harness = new Rosella.Harness();
        var view = harness.default_view();
        factory.add_test_dirs("Winxed", "t", 1:[named("recurse")]);
        var testruns = [];
        for (var dir in args) {
            var testrun = factory.create();
            view.add_run(testrun);
            push(testruns, testrun);
        }
        for (var run in testruns) {
            if (!harness.run(run, view)) {
                view.show_results();
                exit(1);
            }
        }
        view.show_results();
    }

### NQP-rx

Here is a minimal harness written in NQP:

    INIT { pir::load_bytecode("rosella/harness.pbc"); }
    my $factory := Rosella::construct(Rosella::Harness::TestRunFactory);
    $factory.add_test_dirs("NQP", "t", :recurse(1));
    my $testrun := $factory.create();
    my $harness := Rosella::construct(Rosella::Harness);
    my $testview := $harness.default_view();
    $testview.add_run($testrun, 0);
    $harness.run($corerun, $testview);
    $testview.show_results();

## Users

* Rosella uses the Harness library to implement its own unit test harness
* [Parrot-Linear-Algebra](http://github.com/Whiteknight/parrot-linear-algebra)
uses the Harness library for its test harness
