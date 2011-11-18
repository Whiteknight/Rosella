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



### CommandLine.ProgramMode

## Examples
 additional arguments are processed and can lead
to major changes in behavior in the application. A common example is where
programs implement a `--help` or `--version` option. These two options print
me

## Namespaces

## Classes

### CommandLine.Arguments

### CommandLine.Program

### CommandLine.ProgramMode
### Winxed

### NQP-rx

## Users

