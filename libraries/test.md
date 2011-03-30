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

## Namespaces

### Test

The `Rosella.Test` namespace contains the `test` function, which is a facade
over some of the more complex and configurable portions of the library. For
most general-case usages, use the `test` function to execute a test class.

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

### Test.Listener

This is an empty parent class which implements the Listener interface.
Any number of Listener objects can be inserted into `Rosella.Test.Result` to
broadcast results to a number of possible receivers.

This class should not be used directly. You should subclass this class to get
interesting or custom behaviors.

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

TestCase objects are difficult to work with because of the special insulation
which they have been designed with. In order to create and initialize a
TestCase object you must use a TestFactory.

### Test.TestContext

Every test run contains a single `Rosella.Test.TestContext` object which is
shared among all TestCase objects in the Suite. TestContext is used to
provide behaviors and persistant data to tests in the Suite which are not
available in an insulated TestCase environment.

### Test.TestFactory

`Rosella.Test.TestFactory` is used, primarily by the SuiteFactory, to create
TestCase objects for the Suite.

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
