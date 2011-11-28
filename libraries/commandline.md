---
layout: rosella
title: Rosella CommandLine
---

## Overview

Managing commandline arguments can be difficult and require large amounts of
parsing and processing code. Rosella CommandLine library provides some
mechanisms and utilities for working with command line arguments.

## Concepts

### Program Modes

Complex programs may have multiple modes of operation. Certain arguments passed
on the commandline alter the way additional arguments are processed and can lead
to major changes in behavior in the application. A common example is where
programs implement a `--help` or `--version` option. These two options print
program metadata to the console and perform none of normal program logic.

Rosella CommandLine breaks a program up into logical modes. The modes are
determined by certain flag arguments, and direct the program to parse the
remaining arguments differently and dispatch control to different entrypoint
functions.

A program has *at least* two modes: a normal default mode and an error or
fallback mode. The error mode is reached if no other modes can be satisfied
or if there are errors during argument parsing. The default mode is reached if
no other modes are satisfied, but there are no errors during processing.

## Namespaces

## Classes

### CommandLine.Arguments

`Rosella.CommandLine.Arguments` encapsulates all the parsing and lookup behavior
for commandline arguments. Argument definitions are added to the program mode
and are given to the Arguments object, which extracts values from the argument
list. The Arguments object is passed to the entrypoint function after parsing.

### CommandLine.Program

`Rosella.CommandLine.Program` represents a single program instance. The Program
object is in charge of parsing arguments and dispatching control flow to the
correct handler function depending on argument patterns. The Program class
also performs rudimentary error handling.

### CommandLine.ProgramMode

A `Rosella.CommandLine.ProgramMode` is a stand-alone mode of execution for the
running program. Some modes may be trivial, such as printing out an informative
message and exiting when the argument `--help` is passed, while some modes may
dramatically alter the behavior of the program.

## Examples

### Winxed

    function main[main](var args)
    {
        var p = new Rosella.CommandLine.Program(args.shift());
        p.default_mode()
            .set_function(real_main)
            .require_positional("foo", 0)
            .require_positional("bar", 1)
            .require_args({ "mode" : "s", "typed" : "f" })
            .optional_args({ "optimize" : "f", "files" : "*" });
        p.add_mode("help").set_flag("--help").set_function(show_help);
        p.add_mode("version").set_flag("--version").set_function(show_version);
        p.on_error(show_help);
        p.run(args);
    }

    function show_help(var args) { ... }

    function show_version(var args) { ... }

    function real_main(var args)
    {
        string foo = args["foo"];
        string bar = args["bar"];
        string mode = args["mode"];
        int typed = args["typed"];
        int optimize = args["optimize"];
        var files = args["files"];
    }

### NQP-rx

## Users

Several utility functions in Rosella use the CommandLine library to implement
argument parsing and dispatch behavior.

