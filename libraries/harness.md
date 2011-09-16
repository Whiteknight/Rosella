---
layout: rosella
title: Rosella Harness
---

## Overview

The Harness library provides utilities necessary to create a custom test
harness for a TAP-based test suite.

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

TAP Producers will output streams of test data that looks like this:

    1..5
    ok 1
    ok 2 - test name/description
    not ok 3
    # This is a comment
    ok 4 # TODO
    not ok 5 - description # TODO

The first line of the TAP stream is called the *plan*. It shows how many tests
are expected. Every subsequent line will be either a subtest result or a
comment. Successes are listed with "ok" and the number of the test. Failures
are listed as "not ok" with the number. Following the "ok"/"not ok" and test
number there is an optional description and an optional comment. If the first
text in the comment is the string "TODO", the test is marked as such. A
passing test marked TODO is reported as an unexpected pass. A failing test
marked TODO is not listed as a failure in the final report.

Any test file which can generate this kind of output is a valid TAP test.

### MVC

The Harness library follows an MVC architecture. In MVC there are three basic
components: The Model which contains data and logic for the program to use,
the View which displays information to the user, and the Controller which
controls the running of the program and passes data from the Model to the
View.

## Namespaces

### Rosella.Harness

This namespace contains several helper routines for working with global
factory instances. You can get access to the global factories (for
TestExecutor, TapParser, and FileResult objects) in this namespace, or you can
set your own factories for these purposes if you need custom behavior.

## Public Classes

### Harness

The Harness class is a facade over the inner complexity of the library. It
contains the user-friendly methods you need for basic test management and
test suite execution. The Harness creates and manages a list of TestRun
objects, it creates and manages the test results View, and does some other
bookkeeping.

    my $harness := Rosella::build(Rosella::Harness);
    $harness.add_test_dirs(...);
    $harness.add_test_files(...);
    $harness.run();
    $harness.show_results;

### Harness.FileResult

A `Rosella.Harness.FileResult` object represents the result of executing a
TestFile. The Harness essentially acts like a map, taking a list of TestFile
objects and creating a FileResult object for each one. The View operates on
the list of FileResult objects to display information and statistics to the
user.

### Harness.TapParser

The `Rosella.Harness.TapParser` object is responsible for parsing the incoming
TAP stream from an executing test. The TapParser `parse` method takes an input
Query.Stream object with TAP text separated into lines, a FileResult object
and a View object

    // Get a new instance of a TapParser from the default global factory
    var parser = Rosella.Harness.default_tapparser_factory().create();
    parser.parse(stream, view, result);

### Harness.TestExecutor

The `Rosella.Harness.TestExecutor` object is the engine which executes
individual TestFiles. The TestExecutor sets up and executes the test, and
generates a Stream of input lines. It passes that stream to the TapParser,
and then passing on details to the FileResult and the View.

### Harness.TestFile

A `Rosella.Harness.TestFile` object represents a single file in a test suite.
The test file contains zero or more individual tests. In general, TestFile
should not be used directly, it should be used instead with one of various
subclasses for specific types of file.

TestFile objects should be created using the
`Rosella.Harness.TestFile.Factory` class. Do not try to create them directly.

### Harness.TestFile.Automatic

A `Rosella.Harness.TestFile.Automatic` object is a TestFile which
automatically determines how to execute a file based on the first "she-bang"
line in a file. This is a Unix convention. The first line in a test file can
contain the special sequence "`#!`" followed by the name of an executable
program to run with the test file.

Automatic files can only be executed in "spawn" mode. It cannot be used in
"inline" mode.

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

A TestFile type for executing tests written in Winxed.

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

## Examples

### Winxed

Here is a minimal harness written in Winxed, which runs files in "Automatic"
mode in the "t" directory and subdirectories:

    function main[main]() {
        var rosella = load_packfile("rosella/core.pbc");
        var(Rosella.initialize_rosella)("harness");

        var harness = new Rosella.Harness();
        harness
            .add_test_dirs("Automatic", "t", 1:[named("recurse")])
            .setup_test_run();
        harness.run();
        harness.show_results();
    }

Here is a version of the harness which takes a list of test directories from
the command line:

    function main[main](var args) {
        var rosella = load_packfile("rosella/core.pbc");
        var(Rosella.initialize_rosella)("harness");

        var harness = new Rosella.Harness();
        for (var dir in args) {
            harness
                .add_test_dirs("Automatic", dir, 1:[named("recurse")])
                .setup_test_run();
        }
        harness.run();
        harness.show_results();
    }

### NQP-rx

Here is a minimal harness written in NQP:

    INIT {
        my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
        Rosella::initialize_rosella("harness");
    }
    my $harness := Rosella::construct(Rosella::Harness);
    $harness.add_test_dirs("Automatic", "t", :recurse(1)).setup_test_run;
    $harness.run;
    $harness.show_results;

## Users

* Rosella uses the Harness library to implement its own unit test harness
* [Parrot-Linear-Algebra](http://github.com/Whiteknight/parrot-linear-algebra)
uses the Harness library for its test harness
* [Jaesop](http://github.com/Whiteknight/jaesop) uses the Harness library.
* Several Rosella Utility programs use Harness. `rosella_harness` is a default
harness implementation, and `rosella_test_template` can be used to buld a
custom harness.
