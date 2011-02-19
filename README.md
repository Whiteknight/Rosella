# About Rosella

Rosella is a collection of modular building-block libraries, each of which
implements a particular family of patterns, best practices, or other useful
utilities.

Rosella is not a framework and is not monolithic. Rosella is offered as a
collection of individual libraries with very few dependencies between them.
The goal is to be able to provide small features to programmers who want them
without burdening with the overhead of unneeded features.

# Getting, Building, Testing, and Installing

    git clone https://github.com/Whiteknight/Rosella.git Rosella
    cd Rosella
    parrot-nqp setup.nqp build
    parrot-nqp t/harness
    parrot-nqp setup.nqp install

# Component Libraries

Rosella is composed of the following libraries:

## Core (rosella/core.pbc)

A small core library that provides utilities for the other libraries. Not
necessarily intended for public use (but nobody is stopping you!)

## Action (rosella/action.pbc)

A Command/Action pattern library. You can bundle actions up as objects and
invoke them at a later time.

## Event (rosella/event.pbc)

A multicast event system. Objects can subscribe to events by name, and can
receive notifications later when those events are triggered.

## Test (rosella/test.pbc)

A simple TAP test library modeled on Test::Builder and Test::More

## xUnit Tests (rosella/xunit.pbc)

A unit testing library in the spirit of xUnit.

## TAP Harness (rosella/tap_harness.pbc)

A library for quickly and easily building TAP testing harnesses.

## Prototype (rosella/prototype.pbc)

A system for managing object prototypes.

# Influences

Rosella is influenced by a number of other libraries and technologies.
