---
layout: rosella
title: Rosella Memoize
---

## Overview

The Rosella Memoize library provides a set of utilities for performing
memoization on subroutines. Memoization is a mechanism for caching function
return values to save on costly recalculations.

## Concepts

### Simple Memoization

Simple memoization wraps a subroutine (the "target") in a closure with a small
amount of cache code. Simple memoizers are fast and light weight, but do not
have many features. Simple memoizers cannot be examined or modified once they
have been created, and it will not be possible for users of the simple
memoizer to determine whether they are interacting with the target directly
or if they are working with a memoizer.

### Proxy-Based Memoization

Using the Rosella Proxy library, we can create memoizers with proxy objects.
This is a more heavy and more capable alternative to simple memoization.
Proxy-based memoizers allow you to inspect and manipulate the memoizer after
it has been created, at the expense of having more runtime overhead and lower
performance.

With a proxy-based memoizer, user code can determine if the object is a
memoizer or not. If so, the user code can inspect it and retrieve a reference
to the target Sub and Cache, or even modify either of those two fields.

### In-Place Method Memoization

Using proxy-based memoization, Rosella Memoize library can perform in-place
memoization of methods for existing classes. The Memoize library does this by
removing the old method object from the class, wrapping it up in a memoize
proxy, and inserts the proxy into the class where the old method object used
to be. This process is transparent and reversible. Notice that there are
performance implications, the class' method cache must be cleared, which can
cause a period of decreased performance while the cache is refilled.

## Namespaces

### Memoize

The `Rosella.Memoize` namespace represents the friendly public API for the
library. You should try to use the functions here where possible, instead of
attempting to fiddle with other components. This namespace provides the
following functions:

* `memoize`: Create a simple memoizer for the Sub
* `Y`: A Y-combinator implementation with built-in memoization
* `memoize_proxy`: Create a proxy-based memoizer
* `proxy_cache`: Get/set the cache for a proxy-based memoizer
* `proxy_function`: Get/set the target function for a proxy-based memoizer
* `is_memoize_proxy`: Determine if an object is a memoize proxy
* `memoize_method`: in-place memoization for a method
* `unmemoize_method`: in-place unmemoization for a method

## Classes

## Memoize.Controller

## Memoize.Factory

## Memoize.Cache.Item

## Memoize.Cache.SimpleSring

## Examples

### Winxed

### NQP-rx

## Users
