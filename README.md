# About Rosella

Rosella is a collection of modular building-block libraries, each of which
implements a particular family of patterns, best practices, or other useful
utilities.

Rosella is not a framework and is not monolithic. Rosella is offered as a
collection of individual libraries with very few dependencies between them.
The goal is to be able to provide small features to programmers who want them
without burdening anybody with unwanted overhead.

# Getting Rosella

    git clone https://github.com/Whiteknight/Rosella.git Rosella

# Building Rosella

To build Rosella you need to use Winxed:

    winxed setup.winxed build
    winxed setup.winxed test
    winxed setup.winxed install

Winxed is a language compiler for Parrot with a syntax similar to JavaScript.
Rosella libraries are written in Winxed, although they should be usable by
any software written in any language targetting Parrot.

# Component Libraries

Rosella is composed of several libraries. Some are relatively mature, stable,
usable, and tested. Some are still young, in development, or unstable.

## Stable Libraries

### Core (rosella/core.pbc)

A small core library that provides utilities for the other libraries. Not
necessarily intended for public use (but nobody is stopping you!)

### Action (rosella/action.pbc)

A Command/Action pattern library. You can bundle actions up as objects and
invoke them at a later time.

### Container (rosella/container.pbc)

A dependency injection (DI) and inversion of control (IoC) container library.

### Test (rosella/test.pbc)

A unit testing library in the spirit of xUnit and Test::Builder

### TAP Harness (rosella/tap_harness.pbc)

A library for quickly and easily building TAP testing harnesses.

### Proxy (rosella/proxy.pbc)

A library for building proxy objects with a variety of properties and
behaviors.

### Mock Object (rosella/mockobject.pbc)

A library with mock objects for use in unit testing.

## Libraries in Development

### Event (rosella/event.pbc)

A multicast event system. Objects can subscribe to events by name, and can
receive notifications later when those events are triggered.

### Prototype (rosella/prototype.pbc)

A system for managing object prototypes.

### Query (rosella/query.pbc)

A library with query/search routines for working with aggregate objects.

### Decorate (rosella/decorate.pbc)

A library for making inexpensive decorator objects. Decorators are proxies
which transparently pass through all vtable calls to a target object but able
to intercept a specific list of decorator methods and attributes. Also, this
library provides an immutability pattern proxy object which is able to make
other objects immutable.

# Influences

Rosella is influenced by a number of other libraries and technologies. A list
of contributors and specific points of influence will be listed in the
"CREDITS" file.

