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

## Classes

### Container

The `Rosella.Container` class implements the dependency-injection container.
The Container class provides a relatively small public API. Most of the
functionality of the Container is had by passing LifetimeManager, Resolver,
and Option objects to the register and resolve methods.

### Container.Argument

### Container.Argument.Instance

### Container.Argument.Resolver

### Container.LifetimeManager

### Container.LifetimeManager.Permanent

### Container.LifetimeManager.Thread

### Container.LifetimeManager.Transient

### Container.Option

### Container.Option.Attribute

### Container.Option.Initializer

### Container.Option.Method

### Container.Option.Property

### Container.Resolver.Factory

### Container.Resolver.FactoryMethod

### Container.Resolver.Type

### Container.Resolver.TypeConstructor

## Examples

### Winxed

### NQP-rx

## Users
