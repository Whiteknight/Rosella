---
layout: rosella
title: Rosella Core Library
---

## Overview

The Rosella Core library is the central component library of Rosella. It is
a dependency of all other Rosella libraries and provides a small amount of
basic functionality required by all the other libraries.

## Concepts

### Type Keys

Type keys are objects which either are, or can refer unambiguously to, a
Parrot Class. Anywhere Rosella accepts a "type", it can be one of:

* A Class PMC
* A Namespace PMC
* A Key PMC
* A ResizableStringArray PMC
* A string or String PMC
* A P6protoobject Object
* A P6metaclass Object

Any other PMC passed will be stringified to get the name, and that name will
be treated like a String.

### Constructors

By default, Parrot objects do not have anything that could be considered a
real "constructor". That is, there is no standard mechanism through which a
new object can be initialized with a set of default or invariant data.

Rosella provides this mechanism, and allows constructors to be defined in
classes using one of two different formats:

1. A method named BUILD (The "Perl6 Style")
2. A method with the same short name as the class (The "Normal Style")

The Rosella library itself uses the Perl6 Style of constructors internally,
but mechanisms are provided for user code to do differently if needed.

## Namespaces

### Rosella

The Rosella namespace provides a number of mechanisms for working with type
keys.

* `alloc`: Instantiate a new object from the type key
* `build`: Instantiate and BUILD (Perl6 Style) a new object from the
        type key, with arguments
* `construct`: Instantiate and initialize (Normal Style) a new object
        from the type key, with arguments
* `get_type_name`: Get a string which represents the name of the type
* `get_type_class`: Get the Parrot Class PMC associated with the type
* `isa`: Determine if a given object belongs to a type
* `find_named_method`: Find a method on an object by name, null if not found

### Rosella.Error

The Rosella.Error namespace provides a number of error reporting mechanisms
used internally by Rosella to communicate problems.

## Classes

### Rosella.ObjectFactory

The ObjectFactory class is a Factory type which can be used to build objects
from a given type key. Object factory defines two methods, `create` and
`create_typed`.

ObjectFactory can be constructed with an optional type object, which becomes
its default type. If a default type is provided in the constructor,
`ObjectFactory.create` returns a new object of the default type. If a default
type is not provided, `ObjectFactory.create` throws an error.

`ObjectFactory.create_typed` creates a new object of the given type,
disregarding the default type of the factory.

ObjectFactory is the parent type of all other factory objects in Rosella.
The basic ObjectFactory has limited utility, but it provides a common
interface for other, more advanced, factory types.

## Examples

### Winxed

    using Rosella.build;
    // Calls obj.BUILD(arg)
    var obj = build(class My.P6ish.Type, arg);

    using Rosella.construct;
    // Calls obj.Type(arg)
    var obj = construct(class My.Normal.Type, arg)

### NQP-rx

    # Calls $obj.BUILD($arg)
    my $obj := Rosella::build(My::P6ish::Type, $arg);

    # Calls $obj.Type($arg)
    my $obj := Rosella::construct(My::Normal::Type, $arg);
