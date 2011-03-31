---
layout: rosella
title: Rosella Proxy
---

## Overview

The Rosella Proxy Library provides a mechanism for creating configurable,
transparent proxy objects.

## Concepts

### Proxies

A Proxy is a stand-in object, which can be used in place of a "real" object
to provide a variety of behaviors. For instance, a remoting proxy can be used
to provide access to an object which exists remotely, such as in a different
process address space, or on a different machine over the network. An
intercepting proxy can intercept certain accesses, such as certain method
calls, and redirect them or wrap them with additional behaviors. A lazy
loading proxy can be used as a cheap stand-in for an object which is very
expensive to create, and will only cause that object to be created on demand.

### Building Proxies

Proxy objects are created using the `Rosella.Proxy.Factory` class. The factory
uses an array of `Rosella.Proxy.Builder` objects to configure and prepare
the proxy. When the factory is asked to create a proxy, a
`Rosella.Proxy.Controller` object and possibly a target object are provided.

Builders install certain intercepting behaviors on the proxy, which cause
accesses to be redirected. If provided, behaviors will typically be redirected
to the controller. If no controller is provided, the behavior will fallback
to the target object or the target class.

## Namespaces

### Proxy

The `Rosella.Proxy` namespace provides some utilities which are mostly for
internal use by the Proxy library.

## Classes

### Proxy.Builder

`Rosella.Proxy.Builder` is an abstract parent class and should not be used
directly. Use one of the provided subclasses, or create your own subclasses
instead.

A builder provides two methods: `setup_proxy_class`, and `setup_proxy_object`.
These are called by the Factory to setup the proxy. `setup_proxy_class`
is used to configure the Class for proxies by inserting vtable overrides and
methods and attributes to the Class. `setup_proxy_object` is used to configure
the individual proxy object when it is created.

### Proxy.Builder.Array

`Rosella.Proxy.Builder.Array` sets up the proxy to intercept array-like
integer keyed accesses. If you do not use this Builder, and treat the proxy
like an array, you will probably get an error about not having the necessary
vtables defined. There is no default fallback behavior for proxies for integer
keyed access without this builder.

    using Rosella.build;
    var factory = build(class Rosella.Proxy.Factory, class My.Test.Class, [
        build(Rosella.Proxy.Builder.Array)
    ]);
    var proxy = factory.create(controller);
    proxy[5] = "hello";
    var value = proxy[6];

### Proxy.Builder.AttributeIntercept

`Rosella.Proxy.Builder.AttributeIntercept` is used to intercept accesses for
getting and setting attributes.

    using Rosella.build;
    var factory = build(class Rosella.Proxy.Factory, class My.Test.Class, [
        build(Rosella.Proxy.Builder.AttributeIntercept)
    ]);
    var proxy = factory.create(controller);
    proxy.foo = "whatever";
    var value = proxy.bar;

Notice that Parrot's object model does funny things if you try to proxy a
built-in PMC type. In these cases, Parrot's object model uses an attribute
misfortunately named "proxy" to store an instance of the lower-level type
to fall back to under certain situations. AttributeIntercept is set up to
automatically redirect accesses for the "proxy" attribute to the proxy target
object if the type being proxied is a built-in type. If you are proxying a
built-in PMC type, you *must* use AttributeIntercept to provide this behavior.
More details about this will be found in the section about the Passthrough
builder.

### Proxy.Builder.Imitate

`Rosella.Proxy.Builder.Imitate` causes the proxy to look like it is from a
different type by overriding the "does", "isa" and "isa_pmc" vtables. By using
this builder, the proxy should be able to pass runtime checks and pretend to
be a member of a type or types which it otherwise would not appear to be.

Notice that the "can" vtable is tied to the find_method vtable. If you want to
override the behavior of "can", you should use MethodIntercept.

### Proxy.Builder.Immutable

`Rosella.Proxy.Builder.Immutable` creates an immutable proxy. This proxy
blocks access to set_attribute, set_x_native, and other "set_" vtables. If
one of these vtables is invoked, an exception will be thrown. If used with
other Builders which also implement these vtables, Immutable should be
specified last to ensure that the set vtables are locked and not overridden
by other Builders.

### Proxy.Builder.InvokeIntercept

`Rosella.Proxy.Builder.InvokeIntercept` is used to intercept the invoke vtable
for types like Sub which can be invoked.

### Proxy.Builder.MethodIntercept

`Rosella.Proxy.Builder.MethodIntercept` is used to intercept find_method
vtable calls.

### Proxy.Builder.Passthrough

`Rosella.Proxy.Builder.Passthrough` causes the proxy class to be a subclass of
the target type. This forces all unintercepted vtable calls to fallback to the
implementations on the target object. This is useful if we only want to
intercept certain interfaces and let all other accesses fallback to the
object.

In this example, we are trying to proxy the built-in PMC type "String". To do
this, we must also use the AttributeIntercept builder to prevent a variety of
errors.

    using Rosella.build;
    var factory = build(class Rosella.Proxy.Factory, "String", [
        build(Rosella.Proxy.Builder.AttributeIntercept),
        build(Rosella.Proxy.Builder.Passthrough)
    ]);
    var proxy = factory.create(controller);
    proxy.replace("foo", "bar");

### Proxy.Builder.PMCKeyedHash

`Rosella.Proxy.Builder.PMCKeyedHash` intercepts hash-like keyed accesses on
the object.

### Proxy.Builder.StringKeyedHash

### Proxy.Controller

`Rosella.Proxy.Controller` is a type which implements hooks for a proxy to
redirect accesses to. For example, if we use the MethodIntercept Builder,
all find_method vtable calls on the proxy will be redirect to find_method
method calls on the Controller. Consult the individual Builder objects to see
which Controller methods are invoked by the intercepted accesses.

The default Controller type does very little except to attempt to pass through
most accesses to the target object or target class, if those are set. For
more interesting behaviors you should provide your own Constroller subclass.

### Proxy.Factory

`Rosella.Proxy.Factory` creates proxy classes and can be used to allocate
proxies using an array of Builders. The Factory is the only mechanism you
should use for creating proxies. It is not recommended that you try to
subclass Factory. To adjust behavior you should provide new builders or
controllers instead.

## Examples

### Winxed

### NQP-rx

## Users

* The Rosella MockObject library uses Proxy to implement its access intercept
logic
