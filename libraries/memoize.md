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

### Memoize.Controller

`Rosella.Memoize.Controller` is a subclass of `Rosella.Proxy.Controller` for
working with proxy-based memoizers. Do not use this class directly.

### Memoize.Factory

`Rosella.Memoize.Factory` is uses `Rosella.Proxy.Factory` to create memoize
proxies.

### Memoize.Cache

`Rosella.Memoize.Cache` is an abstract parent class used for memoize caches.
You should not use this class directly, but you *must* inherit from it in your
custom cache implementations. The library identifies valid caches by searching
the inheritance tree for this class. If you do not use this as a parent of a
custom cache type, the library may break or exhibit weird behavior.

### Memoize.Cache.Item

`Rosella.Memoize.Cache.Item` is an entry in a cache. Item holds a value and
also a flag to determine if that value is valid. Caches should return Item.

### Memoize.Cache.SimpleSring

`Rosella.Memoize.Cache.SimpleString` uses simple stringification to create
cache keys. This is not a high-performance operation, and it does not work
with objects which cannot be stringified.

## Examples

### Winxed

    // Function to memoize
    function my_function(var a) { ... }

    // Simple memoization
    using Rosella.Memoize.memoize;
    var memoized = memoize(my_function);

    // Proxy-based memoization
    using Rosella.Memoize.memoize_proxy;
    var memo_proxy = memoize_proxy(my_function);
    using Rosella.Memoize.proxy_cache;
    var cache = proxy_cache(memo_proxy);
    using Rosella.Memoize.proxy_function;
    var orig_func = proxy_function(memo_proxy);

### NQP-rx

    # Simple memoization
    sub my_function($a) { ... }
    my &memoized := Rosella::Memoize::memoize(my_function);
    &memoized(4);

    # Proxy-based memoization
    sub my_function($a) { ... }
    my &memo_proxy := Rosella::Memoize::memoize_proxy(my_function);
    my $cache := Rosella::Memoize::proxy_cache(&memo_proxy);
    my $my_function := Rosella::memoze::proxy_function(&memo_proxy);
    &memo_proxy(4);

## Users
