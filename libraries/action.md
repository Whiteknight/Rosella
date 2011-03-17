---
layout: rosella
title: Rosella Action Library
---

## Overview

The Action library implements a kind of Command pattern. An action such as
a subroutine or a method call can be bundled up into an Action object to be
executed later.

## Concepts

### Targets

Every action object takes a target. A target is an object which the action is
performed on. Targets are specified when the action is excuted, not when the
Action is built. This way a single Action object can be executed on a series
of target objects.

### Argument Resolution

Every argument to a subroutine call in Parrot is either positional or named.
If positional, the argument should have a non-zero position number. If named,
the argument should have a non-null name. Arguments with identical positions
or names will be overwritten in a non-deterministic way. Given a list of
Argument objects, no guarantees are made about the order in which they are
resolved.

During argument resolution, an empty array and an empty hash are created.
Each Argument object is executed, inserting one or more values into the array
and/or the hash as necessary. In Action execution, this array and hash are
flattened into a stream of arguments and passed directly to the underlying
function or method.

### Threads

Parrot has no good support for threading right now, and so Rosella Actions do
not pay any attention to threading issues. Once Parrot has an improved and
usable threading system, Rosella's Action library will be upgraded to provide
thread safety and thread dispatch features.

## Classes

### Action

`Rosella.Action` is an abstract parent type which implements the behavior of
actions. You should not use `Rosella.Action` directly. Instead, you should use
an existing subclass or create your own subclass as necessary.

Actions are executed on a target using the `execute()` method. The execute
method takes a target object to perform the action on.

### Action.Sub

`Rosella.Action.Sub` is a simple subroutine Action. When invoked, the
subroutine is invoked, passing the target as the first parameter and all
subsequent parameters passed after that.

In a Sub Action, because the target is passed first, all positional Arguments
are going to have indices off by 1.

### Action.Method

`Rosella.Action.Method` is a method calling Action. When invoked, the method
is invoked on the target, with the arguments passed.

### Action.Argument

`Rosella.Action.Argument` is an object for resolving a value and inserting it
into either the named or positional stream of arguments. Every Argument object
may insert one or more values into the stream of positional and/or named
arguments.

You should pass either a `:position(idx)` or `:named(name)` to the constructor
of the Action subclass to specify where to add the value to the stream. This
is required. If you do not specify either, the Action will throw an exception
when you try to execute it.

`Rosella.Action.Argument` is an abstract parent class and should not be used
directly. You should use either a provided subclass, or create your own
subclass.

### Action.Argument.Instance

`Rosella.Action.Argument.Instance` is an Argument object which inserts a
single existing object instance into the stream. The same exact object will
be passed every time the Action is invoked.

## Examples

### Winxed

### NQP-rx
