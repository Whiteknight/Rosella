---
layout: rosella
title: Rosella Mock Object
---

## Overview

Mock Objects are tools for use in unit testing. Unlike a real object, a
mock object doesn't implement any program logic. Instead, a mock object is
used to verify that code under test is interfacing with objects in a correct
way.

The Rosella MockObject library uses the Rosella Proxy library as the
underlying implementation mechanism for its mock objects.

## Concepts

### Mock Object Limitations

Mock objects can be used to very precisely verify the step-by-step behavior
of an algorithm. However, too much precision can be a bad thing because the
mock objects simulate the behavior of the real objects they are standing in
for, and refactors to the live code must be duplicated in the mock object
tests. Too much precision in a mock object test can therefore increase the
mainenance burden by requiring that all related tests be updated to match
the structure of changed code, even if the new live code would produce the
same results as the old code, only using a new internal algorithm.

Knowing where not to use Mock Objects is just as important as knowing when
to use them and how to make proper use of them in your tests.

## Namespaces

## Classes

### MockObject.Controller

`Rosella.MockObject.Controller` is a `Rosella.Proxy.Controller` object which
uses the intercepted vtable accesses to verify the expectations on the test.

In addition to the normal interface provided by proxy controllers, the
MockObject.Controller class provides methods to get the actual mock object,
to set expectations on that mock, and to verify those expectations have been
met at the end of the test.

To get the mock object from this controller, use the `.mockobject()` method.

To set an expectation on the mock, use one of the expectation methods.
`.expect_method(method_name)` creates a Method expectation.
`.expect_getget(prop_name)` and `.expect_set(prop_name)` create a Get or Set
expectation respectively. `.expect_invoke()` creates an Invoke expectation.
Using these methods, the created expectations are automatically added to the
list of expectations for the Controller and cannot be removed once created.

### MockObject.Controller.Ordered

`Rosella.MockObject.Controller.Ordered` is a subclass of
`Rosella.MockObject.Controller` which requires expectations to be met in the
same order they are defined in. This is useful to verify that a certain
sequence of methods or accesses in an algorithm happens only in a certain
order to prevent e.g. data corruption.

### MockObject.Expectation

`Rosella.MockObject.Expectation` is the mechanism by which we specify what
accesses a mock object should receive. Expectation is an abstract parent
class and should not be used directly. Use the `Get`, `Set`, `Invoke`, or
`Method` subclasses, or a custom subclass instead.

### MockObject.Expectation.Get

Expect a get_attr_str vtable call on the mock, by name. The expectation may
return a value, unlike a Set. A Get may not take any parameters, also
unlike a Set.

### MockObject.Expectation.Invoke

Expects the mock to be invoked like a Sub. Make take any number of positional
or named arguments, and may return a value. An invoke does not have a name, it
is the mock itself.

### MockObject.Expectation.Method

Expect a method invocation, by the name of the method to invoke. Verifies
that the correct method is looked up in find_method and that once invoked the
method has the correct parameters. May take any number of named and positional
parameters, and may return a value.

### MockObject.Expectation.Set

Expect a set_attr_str vtable call on the mock, by name. This expectation may
take a single positional parameter to match, but it may not return a value.

### MockObject.Expectation.Will

`Rosella.MockObject.Expectation.Will` are a a set of behaviors that tell what
the mock will do in response to different accesses. Will is an abstract parent
class and should not be used directly. Use a subclass or create your own
subclass for it.

### MockObject.Expectation.Will.Do

The mock will execute an invokable in response to the access.

### MockObject.Expectation.Will.Return

The mock will return a value from a Get, a Method, or an Invoke expectation.

### MockObject.Expectation.Will.Throw

The mock will throw the specified value as an exception.

### MockObject.Expectation.With

For expectations which take arguments (Method, Invoke, Set), the With value
tells what those values should be. With is an abstract parent class. Use a
subclass or create your own subclass instead.

### MockObject.Expectation.With.Args

Take a verbatim list of arguments. To match, we loop over the given arguments
and make sure they are equal to the expected values.

### MockObject.Expectation.With.Any

Take any number of arguments with any values. This is the default if a With
is not specified on the expectation.

### MockObject.Expectation.With.None

Take no parameters. If any parameters are received, this is an error. Get
expectations may not use None.

### MockObject.Factory

## Examples

### Winxed

### NQP-rx
