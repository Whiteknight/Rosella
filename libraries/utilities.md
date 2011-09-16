---
layout: rosella
title: Rosella Utilities
---

## Overview

In addition to libraries, Rosella provides some helpful utility programs to
help with common programming and maintenance tasks. These programs are
included with the Rosella installation, but may need to be added separately
to your system search path.

## Utilities

### rosella_test_template

The `rosella_test_template` utility is used to create test-related files
quickly and easily. The utility can be used to create test files and
test harnesses in the language of your choice. Currently the languages
supported are winxed and nqp, but other templates could be added in the
future.

To create a new harness, you would do something like this:

    # To create a harness written in winxed
    rosella_test_template harness winxed t/ > t/harness

    # To create a harness written in NQP-rx
    rosella_test_template harness nqp t/ > t/harness

By default the generated harness will execute all test files in the "t"
directory recursively. The default test file type is "Automatic". See
[the Harness documentation](/Rosella/libraries/harness.html) for more
details.

The harness generated in Winxed and the one generated in NQP may differ in
other functionality, such as command-line arguments handled or other details.
These are just rough skeletons, and you should proof-read the generated code
to make sure it does what you need it to do.

This utility can also be used to create a new skeleton test file for a class
in an existing bytecode file. To create a test for your class, you would
write:

    # In Winxed:
    rosella_test_template test winxed mylib.pbc Path.To.Class > class.t

    # In NQP-rx:
    rosella_test_template test nqp mylib.pbc Path.To.Class > class.t

The skeleton test file will be generated which uses Rosella Test to provide
a default test method for every method in the target class. Again, please
proof-read the generated code and tweak the generated logic to meaningfully
test your code.

### rosella_test_all_lib

The `rosella_test_all_lib` utility is like `rosella_test_template` except it
creates an entire test suite for all classes and namespaces in a given
bytecode library. It creates one test file (using the same template and logic
as "`rosella_test_template test ...`") for every class and for every namespace
in the bytecode which contains non-anonymous functions.

    # In Winxed
    rosella_test_all_lib winxed mylib.pbc t/mylib

    # In NQP-rx
    rosella_test_all_lib nqp mylib.pbc t/mylib

### rosella_harness

The `rosella_harness` utility is a default harness which provides basic
behavior. It automatically executes all tests in the `t/` directory, or tests
in any directories passed on the commandline. This can be useful for projects
which have a simple test suite and only need basic behavior from the harness.
All tests are run according to the `#!` "shebang" line at the beginning of the
file. If the file does not contain this line, the test will be marked as
having not been run.

    rosella_harness

    rosella_harness t/foo t/bar t/baz

### winxed_repl

The `winxed_repl` utilitiy is a simple command-line REPL utility for
experimenting with Winxed code. This utility is experimental.

### winxed_mk_header

The `winxed_mk_header` utility is used to automatically generate an includable
Winxed header file with forward declarations for all classes and public
functions in a bytecode file.

    winxed_mk_header mylib.pbc > mylib.include.winxed

## Users
