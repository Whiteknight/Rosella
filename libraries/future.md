---
layout: rosella
title: Future Libraries
---

## Overview

Rosella is a large collection of libraries. At any given time there will be
some libraries in the collection considered "stable" and "usable", and other
libraries in the collection which are still in the planning or development
stages.

This webpage is going to list some of the libraries which are in planning
and development stages. As these libraries grow and mature, they will become
stable and will be listed elsewhere in the documentation.

If *you* are interested in either using or helping to bring them to maturity,
let me know. I'm always interested in new ideas, feedback, and contributions.

## How To Become Stable

To be listed as a stable library, a Rosella library must have:

1. Ample in-code documentation and comments
2. A webpage describing the capabilities and usages of the library
3. Significant test coverage

The library should also be well-designed, have a good and maintainable
architecture, be extendable and configurable, and follow all coding standards.

## Development Libraries

These libraries exist, but are either incomplete, not tested, not documented,
have bad interfaces, suffer from bad or incomplete design, or are otherwise
not mature enough to be considered a stable part of Rosella.

### Contract

A library for performing runtime checks and assertions. The Contract library
implements functionality to verify that certain values hold in certain
ranges, that objects implement required interfaces, and that functions are
both being called correctly and returning correct values. At runtime, the
Contract library can be "turned off", and will not perform any costly checks.

### Decorate

Based on the Proxy library, the Decorate library provides a mechanism for
creating cheap Decorators. A Decorator is an object which adds new
attributes and methods to an object of an existing class, without violating
encapsulation.

### Event

The Event library allows aggressive system decoupling by allowing components
to communicate through events. Events have a subscribe/publish model, where
multiple components can subscribe to be notified of events without knowning
where they were raised, and multiple components are able to publish events
without knowing what (if anything) will be notified.

### Memoize

The Memoize library adds in functionality to add memoization and caching to
subroutines. There is a simple version and a version which uses proxies to add
more features, but is slower.

### Path

The Path library allows searching of nested aggregates by using path strings.
The user of an arbitrary attribute can pick values out of it using search
string.

### Prototype

The Prototype library implements the Prototype pattern. A Prototype is an
object which is cloned to create new objects, as opposed to a normal system of
object creation where objects are allocated fresh and separate initialized.
The Prototype library allows you to register both a prototype object and an
initializer method for each type, then ask for objects of that type by name.

### Query

The Query library implements several higher-order functions for operating on
aggregates. This library implements routines such as map, fold, reduce, count,
and other utility routines for working with aggregates.

## Planned Libraries

These are libaries which exist only on paper (or, more likely, only in my
head). These are just rough plans for things I might like to work on, but
haven't actually written any code for.

### MVC

This library will provide a number of helper utilities to support systems
using an MVC architecture.

### String

The string library will provide a number of utilities for working with
strings in an efficient way.

### Tokenizer

The tokenizer library will implement tokenizing behavior. This library will
implement a mechanism for breaking an input sequence into a sequence of
tokens.

