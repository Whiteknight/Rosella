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

### Aliases

The Container uses a hash internally which is keyed with Class objects. You must
register a type initially using a valid type which can be used to obtain a valid
Class PMC. Older versions of the Container library used string keys.

Once you have registered a type, you may create a string Alias for it, and use
the alias to resolve types by string name instead of by type.

It is important to notice that alias lookups are performed first. If you are
using the string name of a class as the type object for registration, and then
you use that same string as an alias for a different type, you will not be able
use the string type name to get an instance of the original type. This problem,
while abstract, is not uncommon when working with Parrot built-in types from
Winxed.

## Namespaces

### Container

The `Rosella.Container` namespace includes a `default_container` function for
getting an instance to a pre-configured global container instance. You can use
the function `set_default_container` to set a new container instance as the
global default container.

    var c = Rosella.Container.default_container();

## Classes

### Container

The `Rosella.Container` class implements the dependency-injection container.
The Container class provides a relatively small public API. Most of the
functionality of the Container is had by passing LifetimeManager, Resolver,
and Option objects to the register and resolve methods.

    var c = new Rosella.Container();

### Container.Argument

`Rosella.Container.Argument` is a type that is used to fetch an argument value
when calling a function, constructor, or method. This is an abstract parent type
and should not be used directly. Use a subclass instead.

### Container.Argument.Instance

`Rosella.Container.Argument.Instance` is an Argument type that provides a
literal instance value to be used as an argument.

    c.register(class MyType,
        new Rosella.Container.Option.Method("my_method",
            new Rosella.Container.Argument.Instance("foo"),
            new Rosella.Container.Argument.Instance("bar"):[named("baz")]
        )
    );

This example registers the type `MyType` with the container. When it is
resolved, the method `.my_method()` will be called with two arguments: A
positional argument which will be the literal string `"foo"` and the literal
string `"bar"` which will be passed as a named argument with the name `"baz"`.

### Container.Argument.Resolver

`Rosella.Container.Argument.Resolver` is an Argument type that takes a type key
or alias name to lookup in the current container.

    c.register(class MyType,
        new Rosella.Container.Option.Method("my_method",
            new Rosella.Container.Argument.Resolver(class MyOtherType),
            new Rosella.Container.Argument.Resolver(class MyDataType):[named("baz")]
        )
    );

This example is very similar to the one for the Instance Argument type, but uses
the container to resolve objects of the `MyOtherType` and `MyDataType` classes.

### Container.LifetimeManager

`Rosella.Container.LifetimeManager` objects are used to control and manage the
lifetime of objects resolved through the container. For instance, calling the
resolve method on the container more than once with the same type name may
return new instances or pre-existing instances, depending on the specifics of
the lifetime manager object associated with that type.

This is an abstract parent type. Use a subclass instead.

### Container.LifetimeManager.Permanent

The `Rosella.Container.LifetimeManager.Permanent` type keeps a permanent
reference to a single instance once it has been resolved the first time. All
subsequent requests to resolve that type will use the same instance.

    c.register(class MyType,
        new Rosella.Container.LifetimeManager.Permanent()
    );

This example registers the `MyType` type with a Permanent lifetime manager. The
first time this type is resolved a new instance will be created and cached.
All subsequent requests for the type will return the same instance.

### Container.LifetimeManager.Thread

The `Rosella.Container.LifetimeManager.Thread` is similar to the Permanent
lifetime manager except it creates unique instances for each Parrot Thread.
This type is currently unimplemented until Parrot adds threading support.

    c.register(class MyType,
        new Rosella.Container.LifetimeManager.Thread()
    );

This example registers a type `MyType` with a Thread lifetime manager.

### Container.LifetimeManager.Transient

The `Rosella.Container.LifettimeManager.Transient` type is the default
registration behavior. No references are stored, and a new instance is created
fresh and returned every time the container is asked to resolve one.

    c.register(class MyType,
        new Rosella.Container.LifetimeManager.Transient()
    );

This example registers a type `MyType` with a Transient lifetime manager. Notice
that the Transient manager is the default and will be used if no other manager
is provided. The following example is exactly the same:

    c.register(class MyType);

### Container.Option

`Rosella.Container.Option` objects implement various initialization behaviors
and other behaviors. Any number of options can be specified for a given type,
and those behaviors are all executed during resolution by the Resolver unless
the LifetimeManager provides a pre-existing and pre-configured instance to
use instead.

This type is an abstract parent class. Use a subclass instead.

### Container.Option.Attribute

`Rosella.Container.Option.Attribute` initializers are used to set an attribute
value on the new instance.

    c.register(class MyType,
        new Rosella.Container.Option.Attribute("my_attr", "value")
    );

This example sets the value of the attribute `"my_attr"` on the new instance to
the string literal `"value"`. This is the same, but more verbose:

    c.register(class MyType,
        new Rosella.Container.Option.Attribute("my_attr",
            new Rosella.Container.Argument.Instance("value")
        )
    );

Notice that you can also use a Resolver Argument as well.

### Container.Option.Initializer

`Rosella.Container.Option.Initializer` objects are used to execute an
initialization callback function on the new instance to perform arbitrary work.

    c.register(class MyType,
        new Rosella.Container.Option.Initializer(
            function(o) {
                o.foo();
                o.bar = "value";
                my_program.alert_created(o);
            }
        )
    );

This example calls a callback initializer function on the new object when it
has been created. This performs some work on the new object and even calls
another method somewhere else to alert that the object has been created.

### Container.Option.Method

`Rosella.Container.Option.Method` initializers are used to call a method on
the new instance.

    c.register(class MyType,
        new Rosella.Container.Option.Method("my_method",
            new Rosella.Container.Argument.Instance("foo"),
            new Rosella.Container.Argument.Resolver(class MyValueClass)
        )
    );

### Container.Option.Property

`Rosella.Container.Option.Property` initializers are used to set a property
value on the new instance.

    c.register(class MyType,
        new Rosella.Container.Option.Propery("my_prop", "value")
    );

### Container.Resolver

`Rosella.Container.Resolver` objects are used to create a new, unconfigured
instance of the requested type. Resolvers can create new instances using a
variety of techniques.

During type resolution, the Resolver asks the associated Lifetime Manager if
there are any existing instances which can be reused. If so, the Lifetime
Manager returns an existing instance. Otherwise, the Resolver creates one and
executes its list of initializer Options on the new instance.

This is an abstract parent type. Use a subclass instead.

### Container.Resolver.Factory

`Rosella.Container.Resolver.Factory` uses an existing factory object to create
an instance of the requested type. The factory object, the name of the method
to call to obtain a new instance, and an optional list of Argument objects to
pass to that method must be provided.

Here is an example which utilizes a Rosella.ObjectFactory for the factory to
use:

    var f = new Rosella.ObjectFactory(class MyType);
    c.register(class MyType,
        new Rosella.Container.Resolver.Factory(f, "create");
    );

And here is a similar example, with arguments to pass to the `create` method:

    var f = new Rosella.ObjectFactory(class MyType);
    c.register(class MyType,
        new Rosella.Container.Resolver.Factory(f, "create",
            new Rosella.Container.Argument.Instance("value 1")
            new Rosella.Container.Argument.Resolver(class MyOtherType)
    );

### Container.Resolver.FactoryMethod

`Rosella.Container.Resolver.FactoryMethod` uses a factory method callback to
create an instance of the requested type. The factory method is a 0-arity Sub
which will be given no arguments and must return exactly one object: the
requested instance.

    c.register(class MyType,
        new Rosella.Container.Resolver.FactoryMethod(
            function() { return new MyType(); }
        );
    );

### Container.Resolver.Instance

The `Rosella.Container.Resolver.Instance` resolver type takes a pre-existing
instance and returns that same exact instance every time an object of that
type is requested.

Notice that the Instance resolver and the Permanent lifetime manager do almost
exactly the same thing. The key difference is that the Instance Resolver takes
an instance up front that must be created *before* the registration. The
Permanent lifetime manager will allow the resolver to lazily create an instance
the first time it is requested and will cache that instance there after.

    var instance = new MyType();
    c.register(class MyType,
        new Rosella.Container.Resolver.Instance(instance)
    );

### Container.Resolver.Type

The `Rosella.Container.Resolver.Type` resolver uses a Type object and normal
Rosella (winxed-style) constructor behavior to create a new object. Arguments
may be provided which will be passed to the default constructor.

    c.register(class MyType,
        new Rosella.Container.Resolver.Type(class MyType)
    );

This is the default behavior. This example has exactly the same result:

    c.register(class MyType);

This Resolver is useful for substituting a Subclass for the existing class:

    c.register(class MyType,
        new Rosella.Container.Resolver.Type(class SubclassOfMyType)
    );

### Container.Resolver.TypeConstructor

The `Rosella.Container.Resolver.TypeConstructor` is similar to the Type resolver
except it gives you the ability to specify a constructor by name and pass in a
list of Argument objects to it.

    c.register(class MyType,
        new Rosella.Container.Resolver.TypeConstructor(class MyType, "BUILD")
    );

## Examples

### Winxed

### NQP-rx

## Users
