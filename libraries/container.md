---
layout: rosella
title: Rosella Container
---

## Overview

The Rosella Container library implements an Inversion-of-Control,
Dependency-Injection container type.

## Concepts

### Registration and Resolution

The container allows two basic operations: Registration and Resolution.

In Registration, the user provides a type and a series of resolution rules. The
key can be any Rosella Type object.

In resolution, the user asks the container for an object with the same type.
The container will "resolve" an object following the registered rules for that
key. In this context, the verb "resolve" can mean that the container returns
an existing object which matches the rules, or it can allocate and possibly
initialize a fresh new object. What you get back is what the container has been
configured to give you.

### Registration Rules

Registration consists of multiple parts. At the very least, a type must be
provided which tells the container which type of object you want. After you
specify a type, you may specify a Resolver, a Lifetime Manager, and any number
of initializer Options.

When a type is resolved by the container the Resolver object may create an
instance or the Lifetime Manager may return an existing instance. Once the
instance is obtained, all the initializer Options are executed on it to
set up the object for use.

If the container is asked to resolve a type which has not been previously
registered, it will fall back to basic type resolution with a default (winxed
style) constructor. Rules such as the Resolver to use and the specific
initialization Options to use for the object can be set at registration time or
overrides for these can be provided when Resolving.

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

## Public Classes

### Container

The `Rosella.Container` class implements the dependency-injection container.
The Container class provides two basic sets of public methods: Register and
Resolve.

## Private Classes

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

Register the type "String" to return a string. This string will have an
initial value, and will then be modified:

    my $c := Rosella::build(Rosella::Container);
    $c.register_type("String",
        :meth_inits([
            Rosella::build(Rosella::Action::Sub,
                sub ($obj) {
                    pir::set__vPS($obj, "FooBarBaz");
                }, []
            ),
            Rosella::build(Rosella::Action::Method,
                "replace", [
                    Rosella::build(Rosella::Action::Argument::Instance, "B", :position(0)),
                    Rosella::build(Rosella::Action::Argument::Instance, "C", :position(1))
                ]
            )
        ]
    ));
    my $bar := $c.resolve("String");    # "FooCarCaz"

Register an entry which returns a unique ID integer every time it is resolved:

    my $c := Rosella::build(Rosella::Container);
    my $seed := pir::box__PI(5);
    $c.register_instance("UniqueID",
        $seed
        :meth_inits([
            Rosella::build(Rosella::Action::Sub,
                sub ($obj) {
                    pir::inc__vP($obj);
                }, []
            ),
        ]
    ));
    my $a := $c.resolve("UniqueID");    # 6
    my $b := $c.resolve("UniqueID");    # 7
    my $c := $c.resolve("UniqueID");    # 8

## Users
