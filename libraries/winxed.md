---
layout: rosella
title: Rosella Winxed
---

## Overview

The Rosella Winxed library provides some basic functionality, especially with
respect to the Parrot distutils library, to build and manage projects written
in Winxed.

This library may expand to include additional abilities, if glaring feature
ommissions are found in the Winxed language or in other toolsets and libraries
which are not natively compatible with Winxed.

## Concepts

### Distutils

The Distutils library is part of the Parrot distribution. It is used to help
create building, installation, packaging, and testing infrastructure for a
project. Distutils contains built-in functionality to support library projects
written in PIR and NQP, as well as other types of extension and embedding
projects. Distutils by default does not contain features for building
libraries written in Winxed (such as Rosella).

### Winxed Build Rules

Distutils is a data-driven program. To set up files to build, you assign
them in a hash to a given rule. For instance, the rule "pbc_pir" compiles
PIR files to PBC files. The Winxed library adds the "pir_winxed" rule,
which compiles a .winxed file down to a .pir file.

### REPL

## Namespaces

### Rosella.Winxed.Distutils

This namespace contains all the necessary utility functions to be able to
build winxed files with distutils.

## Classes

### Winxed.Repl

`Rosella.Winxed.Repl` implements a Read-Eval-Print Loop (REPL) for Winxed. It
is currently under development and not considered a stable part of the library
yet. More documentation will come as the system becomes more mature.

### Winxed.Repl.State

## Examples

### Winxed

    var data = {
        "pir_winxed" : {
            "my_winxed_file.pir" : "my_winxed_file.winxed"
        },
        "pbc_pir" : {
            "my_winxed_file.pbc" : "my_winxed_file.pir"
        },
    };
    using Rosella.Winxed.Distutils.winxed_setup;
    winxed_setup();
    setup(args, data);

### NQP-rx

    %data{"pir_winxed"} := {};
    %data{"pir_winxed"}{"my_winxed_file.pir"} := "my_winxed_file.winxed";
    %data{"pbc_pir"} := {};
    %data{"pbc_pir"}{"my_winxed_file.pbc"} := "my_winxed_file.pir";
    Rosella::Winxed::Distutils::winxed_setup();
    setup(@args, %data);

## Users

* Rosella uses the Winxed library to implement its own setup.winxed script
