---
layout: rosella
title: Rosella Container Library
---

## Overview

The Rosella Container library implements an Inversion-of-Control,
Dependency-Injection container type.

## Concepts

### Registration and Resolution

The container allows two basic operations: Registration and Resolution.

In Registration, the user provides a key and a series of resolution rules. The
key can be any Rosella Type object, or it can be any arbitrary string.

In resolution, the user asks the container for an object with the same key.
The container will "resolve" an object following the registered rules for that
key. In this context, the verb "resolve" can mean that the container returns
an existing object which matches the rules, or it can allocate and possibly
initialize a fresh new object.

### Registration Rules

Registration Rules have two parts: A mechanism for fetching or allocating an
object of a given type (a `Rosella.Container.ItemFactory`) and a series of
actions to initialize the new object (`Rosella.Action`).

When an key is resolved, the associated ItemFactory creates or fetches the
object, and then the array of Action objects are executed on the new object to
initialize it.

If the container is asked for a key which has not been previously registered,
the container by default will fall back to asking it a default object factory
(`Rosella.ObjectFactory`) to create that object. The default ObjectFactory
cannot handle creating from an arbitrary string that does not correspond to
an existing Parrot Class PMC. You can provide your own custom factory instead
to handle these kinds of cases.

### Keys Best Practices

The Container can take any type as a key for registering and resolving
objects. Internally, the key is stringified using `Rosella.get_type_name`, and
the string name is used to store the registration rules in a hash. Because
of this design aspect, any arbitrary string can be used to register rules in
the container, not just strings representing valid type objects.

There are two points to consider here. First, user code will ask the container
to return objects of a particular type, and those objects may be used as if
they are, or transparently appear to be, of that type. Second strings can be
used which do not correspond to a type, and these arbitrary string keys should
not conflict with a valid type that does or could exist in user code. If you
are going to use an arbitrary string to register in the container, try to pick
one which is not a stringification of a valid class. In most cases, you will
want to use registration keys which are not valid class names in the current
HLL, such as one that contains non-identifier characters.

It is considered very bad practice to register an object or object resolution
rules for a type which will produce an object of a different type. If I ask
for a "Foo", I expect to receive back something which is, or can transparently
act like a Foo. If you return some other arbitrary object, you may break
assumptions in other code, and cause lots of headaches. Rosella's Container
library does not automatically perform any sanity checking to verify that
the registered resolution rules for a particular key will actually produce an
object of that type. Because of the dynamic nature of the system, there is no
possible way to perform these kinds of automatic checks either. Users of the
Container library should therefore take particular care to ensure that when
the user asks for an object of a particular type, that an object of that type
is actually returned.

## Namespaces

### Container

## Classes

### Container

The `Rosella.Container` class implements the dependency-injection container.
The Container class provides two basic sets of public methods: Register and
Resolve.

### Container.ItemFactory

`Rosella.Container.ItemFactory` inherits from `Rosella.ObjectFactory`.
ItemFactory object only implement `create`, and will throw an exception if you
call `create_typed`. Unlike ObjectFactory, the ItemFactory constructor takes
an array of Action objects which are used on the newly allocated object to
initialize it.

ItemFactory itself is an abstract parent type and should not be used directly.
Use one of the provided subclasses, or create your own subclass as needed.

### Container.ItemFactory.FactoryMethod

`Rosella.Container.ItemFactory.FactoryMethod` is an ItemFactory which takes
an arbitrary invokable PMC. When we attempt to resolve the item, The
invokable is executed and the return value is treated as the object.

### Container.ItemFactory.Instance

`Rosella.Container.ItemFactory.Instance` is an ItemFactory which returns a
single pre-existing instance object, which must be provided during
registration.

### Container.ItemFactory.P6protoobject

`Rosella.Container.ItemFactory.P6protoobject` takes a P6protoobject, and
uses that to instantiate a new object. This is typically used when using
Rosella Container from a program written in NQP-rx.

### Container.ItemFactory.ParrotClass

`Rosella.Container.ItemFactory.ParrotClass` takes a Parrot Class PMC, and
uses that to instantiate a new object.

### Container.ItemFactory.Prototype

`Rosella.Container.ItemFactory.Prototype` takes a prototype object, and clones
it to create new objects on command.

### Action.Argument.ContainerResolver

The `Rosella.Action.Argument.ContainerResolver` type is a subclass of
`Rosella.Action.Argument` from the argument library. This action type uses a
Container object to resolve an argument.

## Examples

### Winxed

### NQP-rx
