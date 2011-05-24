---
layout: rosella
title: Rosella Query
---

## Overview

The Rosella Query library is a library for performing higher-order functions
on aggregate data. Aggregates are things like arrays and hashes, where an
object contains many related child objects. The Rosella Query library is based
in no small part on ideas from the .NET System.Linq library, although many of
the routine names are changed and the interfaces have been modified to suit
the capabilities of the Parrot Virtual Machine.

## Concepts

### Functions and Predicates

The Query library takes two types of function objects for it's routines:
regular functions and predicates. This is mostly a difference in terminology.
A function is one that takes one or more data values and is expected to return
another data value. A Predicate is a function that is expected to take one or
more data values and return a boolean. Typically the boolean value is an
answer to the question "Does this value belong in the result set?".

### Map, Filter, and Fold

Map, Filter, and Fold are the classic higher-order functions. They have
well-known behaviors and can be combined together in powerful ways.

Map iterates over the data, producing a new item in the results set for each
element in the input set. The result of a Map operation is always the same
type of aggregate (array or hash) as the input data. It will also always have
the same number of elements. In the case of a hash aggregate, the output hash
has the same keys.

Filter iterates over the data, only copying items which satisfy a predicate
into the result set. The result of a Filter operation is the same type as the
input aggregate (array or hash), although it will typically have fewer
entries. In an array result the surviving elements are moved forward and
indices are not preserved. In a hash result, the surviving elements have the
same keys. If Filter is used on a scalar, the result will either be the scalar
itself (if it passes the filter) or null. If the original scalar data is null,
the two results are indistinguishable.

Fold (also known as "Reduce") iterates over the input data, combining the
elements together into a single result. The result of a Fold is always a
scalar.

### Take and Skip

Take and skip reduce a set by a specified number, starting at the beginning
of the aggregate. In the case of Take, only the first N items are stored in
the results set. If N is larger than the aggregate, all items are included in
the result. In Skip, we skip the first N items and return all the rest. Both
of these methods can take a predicate. If provided, the predicate is used with
a filter-like operation to reduce the input set first, before the items are
counted and partitioned.

For array aggregates, result sets are calculated in order. So `.take(3)` will
return a new array with items 0, 1, and 2 from the input data. Likewise, Skip
will return items from the end of the array. For hash aggregates, there is no
idea of ordering. The take and skip routines use iterators, and dutifully take
or skip items from the iterator in the order they are presented. Where the
iterator does not preserve order, the result sets may appear to be randomly
selected.

`.skip(0)` always returns a complete copy of the input data. `.take(0)` always
returns an empty aggregate (or null, for scalars). For Scalar data, Take with
any positive number returns the scalar itself, while Skip with any value
greater than 1 returns null

### Count, Any, Single, and First

Count returns a count of elements in the aggregate. Count can take an optional
predicate and will return the number of items which match that predicate if
provided.

Any returns true if there are any items in the aggregate, or any items which
match an optional predicate. This behavior is intended to be as lazy as
possible.

Single expects an aggregate with exactly one element. Single returns that
element, as a Scalar Queryable. If the aggregate has zero elements or more
than 1, an exception is thrown.

First returns the first item in the aggregate, or the first item which
matches an optional predicate. As with the note above about skip and take,
hash aggregates are not expected to be ordered and the notion of "first" may
be nonsensical. If the aggregate is empty, First throws an exception. There
is a variant called `.first_or_default` which returns a default value (null,
unless specified otherwise) if the aggregate is empty.

## to_array and to_hash

The Query library can convert between hash and array types, or remap the
items in a hash to new positions.

The `to_array` method returns an array queryable. Where the input data is an
array, `to_array` returns a copy of it. Where the input data is a hash,
`to_array` returns an array of the values of the hash (in the order returned
by the hash iterator).

The `to_hash` method returns a hash queryable. It takes a function reference
to be used for generating the key of the hash. The key generator function only
takes the data item as input, not the key for an existing hash.

## data and unwrap_first

There are two methods for pulling data out of a queryable without wrapping it
back into another queryable. The first, `.data()` returns the complete data
object reference from the Queryable. The second, `.unwrap_first` is a method
on Provider only and is not accessable through Queryable. It returns the first
item from an aggregate, such as the first item in an array, or the first item
from a hash iterator.

## Namespaces

### Rosella.Query

The `Rosella.Query` namespace provides some utility functions. The
`as_queryable` routine is the most important. That function takes an aggregate
or other data and wraps it in a `Rosella.Query.Queryable` object.

## Classes

### Query.Provider

`Rosella.Query.Provider` is an abstract base class for query providers. Each
provider handles querys for a specific type of object. This class outlines the
interface and provides a few common method implementations. Do not use this
class directly. Use a subclass instead.

Providers typically do not have state, so the few types provided by the Query
library by default are singletons. Custom implementations do not need to be
singletons, however.

### Query.Provider.Array

`Rosella.Query.Provider.Array` is a query provider for arrays and array-like
structures. In uses integer-based indexing to operate on arrays in order.

### Query.Provider.Hash

`Rosella.Query.Provider.Hash` is a query provider for hashes and hash-like
objects. It uses string-key indexing to operate on hashes. Notice that hashes
are not expected to be ordered, so querys on hashes are not necessarily
ordered or deterministic between program runs.

### Query.Provider.Scalar

`Rosella.Query.Provider.Scalar` provides query behavior for data which is not
an array or a hash. This is a degenerate form of the other providers, and
always operates under the assumption that the data is exactly one element.
The `.count()` method always returns 1, `.take()` always returns the element
itself, `.skip` usually returns null, etc.

### Query.Queryable

`Rosella.Query.Queryable` is a wrapper type which adds a variety of methods
to a data aggregate and associates it with a query provider. Almost all
methods on Queryable return another Queryable with the results set, so
operations can be neatly chained together.

Methods on Queryable always return a new Queryable object.

Queryable is the preferred interface for using the Query library, although
providers can be used directly if desired. Providers do typically provide a
more flexible, if more verbose, interface.

The best way to get a Queryable for your data is to use the
`Rosella.Query.as_queryable` function.

The `.data()` method returns the data object stored inside the Queryable.

### Query.Queryable.InPlace

Unlike Queryable, `Rosella.Query.Queryable.InPlace` always returns itself
from each method. This preserves the same chaining behavior as Queryable, but
removes the overhead of generating extra Queryable objects for each stage.

## Examples

### Winxed

This example, from the test suite, uses `.map`, `.filter` and `.fold`. It uses
map to square each entry. Then it uses filter to select only the odd squares.
Finally, it uses fold to sum all the squares together. The sum of 1 + 9 + 25
+ 49 + 81 = 165.

    var data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    using Rosella.Query.as_queryable;
    int sum = as_queryable(data)
        .map(function(int i) { return i * i; })
        .filter(function(int j) { return j % 2; })
        .fold(function(int s, int i) { ret s + i; })
        .data();
    say(sum); # 165

### NQP-rx

Same sum-of-odd-squares example from above, in NQP-rx:

    my @data := data(1, 2, 3, 4, 5, 6, 7, 8, 9);
    my $sum := Rosella::Query::as_queryable(@data, 1).map(
        -> $i { $i * $i; }
    ).filter(
        -> $j { $j % 2; }
    ).fold(
        -> $s, $i { $s + $i; }
    ).data;
    pir::say($sum); # 165

## Users
