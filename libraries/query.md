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

### Queryables and Iterables

The Query library has two major types of objects: Queryables and Iterables. A
Queryable is an eager object which performs higher-order routines on an
existing in-memory aggregate. For instance, a Queryable can operate on an
existing Array object, perform operations on the contents, and return a new
Array. Queryables tend to have a little bit less overhead and can have better
performance, but they are also eager and not suitable for use with infinite
data sources.

Calling the "map" method on a Queryable Array will perform the mapping in a
tight loop and return a fresh new array. Calling the map method on an Array
Iterable will return the Iterable with that mapping integrated into the fetch
logic. Every access of an item on the Iterable reads a new item from the Array
and performs the mapping on that item only. All other consumers of the stream
will not know that any mappings have been applied to it, and the data source
(the Array) will be read lazily.

Queryables tend to work best with in-memory objects which are Arrays or
Hashes. They are eager and relatively quick, using type-specific optimizations
for different operations where possible. Queryables will try to preserve
semantics of the input type. For instance, creating a Queryable for an Array
object will typically return results in an array format. Queryables with Hash
data will typically return results as Hashes. Methods such as `.to_array()`,
`.to_hash()`, `.sort()` or `.fold()` may modify the storage type.

Iterables work like normal Parrot Iterators, with several new methods and
semantics. They tend to work best with objects which are lazy and iterable. For
instance, the lines of text in a very large file may be best read one at a
time instead of reading the whole contents of a file into a large blob of
in-memory text and attempting to work with it all at once. Lines of input from
a Pipe from a long-lived subprocess, or a network Socket might not be limited
in number, and attempting to read all data into a single blob may hang the
program. Using an Iterable over these sources ensures that lines would be read
individually and only on demand. Iterables always treat data as sequential and
array-like. They also tend to be one-way structures. Once you read data from the
Iterable you need to explicitly `.reset()` the object in order to read the
values again. Not all Iterables support `.reset()`, so some reads may only be
done once. Besides the creation of iterators over the target data, the Iterable
never modifies and rarely accesses the original data.

Modifying the target data externally during iteration is not recommended and may
cause weird unwanted effects or even throw exceptions. Don't do it.

### Functions and Predicates

The Query library takes two types of function objects for it's routines:
regular functions and predicates. This is mostly a difference in terminology.
A function is one that takes one or more data values and is expected to return
another data value. A Predicate is a function that is expected to take one or
more data values and return a boolean. Typically the boolean value is an
answer to the question "Does this value belong in the result set?". For
example, the `.filter()` method on Queryable and Stream takes a predicate
which returns true if the data should be included, and false if the data
should be excluded. The `.count()` method takes an optional predicate which,
if provided, determines which objects should be included in the count.

### Map, Filter, and Fold

Map, Filter, and Fold are the classic higher-order functions. They have
well-known behaviors and can be combined together in powerful ways.

Map iterates over the data, producing a new item in the results set for each
element in the input set. The result of a Map operation on a Queryable is
always the same type of aggregate (array or hash) as the input data. Maps on
Iterables return a sequence of the mapped values. It will also always have
the same number of elements.

Filter iterates over the data, only copying items which satisfy a predicate
into the result set. The result of a Filter operation on a Queryable is the
same type as the input aggregate (array or hash), although it will typically
have fewer entries. In an array result the surviving elements are moved
forward and indices are not preserved. In a hash result, the surviving
elements have the same keys. If Filter is used on a scalar, the result will
either be the scalar itself (if it passes the filter) or null. If the original
scalar data is null, the two results are indistinguishable. For Streams, a
filter operation will return the current data if it matches the predicate, or
it will pull a new piece of data from the source until it does.

Fold (also known as "Reduce") iterates over the input data, combining the
elements together into a single result. The result of a Fold is always a
scalar. For Iterables, the Fold operation is eager and will read all remaining
data from the source.

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
greater than 1 returns null.

For Iterables, the Take operation acts like a limit for the number of items
retrieved. Once the maximum number of items have been taken, no more data will
be read from the source. The skip operation is likewise lazy. It immediately
reads through the first N items from the source and discards them. It then
returns all subsequent items unaltered.

### Count, Any, Single, and First

Count returns a count of elements in the aggregate. Count can take an optional
predicate and will return the number of items which match that predicate if
provided. In Iterables, Count is eager and will read all remaining data from the
source. The Iterable must be reset before the data can be read again. Notice
that resetting the Iterable, in some cases depending on implementation, might
alter the count of items. For example, if a `.project()` call returns a variable
number of items depending on context-sensitive data, it can return a different
number of elements the second time it is called on the same object.

Any returns true if there are any items in the aggregate, or any items which
match an optional predicate. This behavior is intended to be as lazy as
possible. In Iterables Any is lazy. It reads items from the source until the
predicate is satisfied. Data that is read during Any is lost unless the Iterable
is reset. Any only reads data if there are predicates to test and if the first
element in the data does not satisfy the predicate. Otherwise, it should not
read any data.

Single expects an aggregate with exactly one element. Single returns that
element, as a Scalar Queryable. If the aggregate has zero elements or more
than 1, an exception is thrown.

First returns the first item in the aggregate, or the first item which
matches an optional predicate. As with the note above about skip and take,
hash aggregates are not expected to be ordered and the notion of "first" may
be nonsensical. If the aggregate is empty, First throws an exception. There
is a variant called `.first_or_default` which returns a default value (null,
unless specified otherwise) if the aggregate is empty.

### to_array and to_hash

The Queryable object can convert between hash and array types, or remap the
items in a hash to new positions.

The `to_array` Queryable method returns an Array Queryable. Where the input data
is an array, `to_array` returns a copy of it. Where the input data is a hash,
`to_array` returns an array of the values of the hash (in the order returned
by the hash iterator). Hash keys are lost irretrievably. For Iterables,
`to_array` returns a normal Parrot array (usually a ResizablePMCArray) of the
input objects, not a new Iterable.

The `to_hash` Queryable method returns a hash Queryable. It takes a function to
be used for generating the hash key from the data item. The key generator
function only takes the data item as input, not the key for an existing hash.
Old hash keys are lost irretrievably. For Iterables, `to_hash` returns a new
Parrot Hash PMC with the given keys. `to_hash` also takes an optional second
argument, a function for selecting data for each key.

### data, next, execute and unwrap_first

There are two methods for pulling data out of a Queryable without wrapping it
back into another queryable. The first, `.data()` returns the complete data
object reference from the Queryable. The second, `.unwrap_first` is a method
on Provider only and is not accessable through Queryable. It returns the first
item from an aggregate, such as the first item in an array, or the first item
from a hash iterator.

For Iterables there are several methods for retrieving results. The `.to_array`
and `.to_hash` methods have already been discussed. The `.foreach` method
iterates the source performing a callback on each item. The `.execute` method
iterates the source and performs no callback and returns no value (useful if
side-effects are wanted only). The `.next()` method retrieves the next single
value from the stream. Notice that calling `.next()` may draw several items from
the source iterable or none at all. For instance, if the iterable contains
filter logic where some items do not match the predicate, multiple items may
need to be read to find an item that can be returned. Also, if a part of the
iterable has cached data from a previous calculation, calling `.next` might
return items from the cache and won't touch the source.

## Namespaces

### Rosella.Query

The `Rosella.Query` namespace provides some utility functions. The
`as_queryable` function takes an aggregate or other data and wraps it in a
`Rosella.Query.Queryable` object. The `as_stream` function takes an iterable
value and returns a `Rosella.Query.Stream` object. These methods should be
used instead of calling constructors on Stream or Queryable directly.

### Rosella.Query.Sort

The `Rosella.Query.Sort` namespace provides several sort algorithm
implementations and helper routines for sorting data. These typically do not
need to be accessed directly. Instead, use the `Rosella.Query.sort_array`
function to perform in-place array sorts.

## Classes

### Query.Iterable

`Rosella.Query.Iterable` is the base type for all Iterables. It provides the
API and default implementations that all Iterables use. Iterables are not used
directly, but subclasses of it are.

The best way to create an Iterable for your data is to use the
`Rosella.Query.iterable(d)` function.

### Query.Iterable.Append

The `Rosella.Query.Iterable.Append` Iterable appends additional data to the end
of the current iteration.

    var d = [1, 2, 3];
    var i = Rosella.Query.iterable(d)
        .append([4, 5, 6])

### Query.Iterable.Array

The `Rosella.Query.Iterable.Array` Iterable is a source iterator for arrays and
array-like data. It is a Source Iterable and reads data from no other source
besides the array provided to it.

### Query.Iterable.Factory

The `Rosella.Query.Iterable.Factory` type is used to create a Source Iterable
from a given data aggregate. It is called automatically from the
`Rosella.Query.iterable()` both and you probably don't need to work with it
directly.

### Query.Iterable.Filter

The `Rosella.Query.Iterable.Filter` performs a filtering operation on data. It
takes a predicate argument. Only objects which satisfy the predicate (return
true) are included in the output.

    var d = [1, 2, 3];
    var i = Rosella.Query.iterable(d)
        .filter(function(o) { return int(o) % 2 == 1; });

### Query.Iterable.Flatten

The `Rosella.Query.Iterable.Flatten` Iterable flattens nested aggregates into a
single sequence of primitive values.

    var d = [1, [2], [[3], 4]];
    var i = Rosella.Query.iterable(d)
        .flatten(); // returns sequence 1, 2, 3, 4

### Query.Iterable.GroupBy

The `Rosella.Query.Iterable.GroupBy` Iterable groups like objects into arrays,
and returns a sequence of name/value pairs of arrays. It takes a function which
receives each data item and returns a key. Items with the same keys are grouped
into arrays, and those arrays are added to a hash under that key.

    var d = [1, 2, 3, 4, 5];
    var h = Rosella.Query.iterabl(d)
        .group_by(function(i) { return i % 2; })
        .to_hash(function(k) { return k.key(); }, function(k) { return k.value(); });

    // same as:
    var h = {
        0 : [2, 4],
        1 : [1, 3, 5]
    };

### Query.Iterable.Hash

The `Rosella.Query.Iterable.Hash` Iterable is a source iterable which reads
data from Hashes and hash-like PMCs. The Hash Iterator returns a sequence of
KeyValuePair objects for each hash entry. They are not returned in any
particular order and ordering of data from a Hash should not be relied upon.

A Hash Iterable is created automatically using the `Rosella.Query.iterable()`
function. You should not need to create it directly.

### Query.Iterable.Iterator

The `Rosella.Query.Iterable.Iterator` Iterable is a source iterable which reads
data from an existing Parrot Iterator type. A valid iterator for use with this
type is any object which implements the "iterator" role and fulfills the same
API as other built-in Parrot iterator types. The Iterator Iterable reads data
directly from the underlying iterator. This iterator *cannot be reset* with the
`.reset` method because Parrot iterators do not support that operation.

An Iterator Iterable is created automatically using the
`Rosella.Query.iterable()` function. You should not need to create it directly.

### Query.Iterable.KeyValuePair

A `Rosella.Query.Iterable.KeyValuePair` object is used in the iteration of
Hashes. The KeyValuePair is a pair of a hash key and the corresponding hash
value.

    var h = {"a" : 1, "b" : 2, "c" : 3};
    var g = Rosella.Query.iterable(h)
        .to_hash(
            function(kvp) { return kvp.key(); },
            function(kvp) { return kvp.value(); }
        );

KeyValuePair is considered an immutable type and the attribute values should
not be modified after it has been created. It provides only two methods, one
to access the `.key()` and one to access the `.value()`.

### Query.Iterable.Map

A `Rosella.Query.Iterable.Map` Iterable performs a mapping where each input data
item is transformed to a different data item on output.

    var d = [1, 2, 3];
    var i = Rosella.Query.iterable(d)
        .map(function(j) { return string(j) + " beers on the wall"; });

### Query.Iterable.Project

A `Rosella.Query.Iterable.Project` Iterable projects each item in the input
sequence into one or more output items. Project takes a function which takes a
data item and returns an array (or hash) of items. Those output items are each
individually passed to subsequent iteration stages.

### Query.Iterable.Shuffle

A `Rosella.Query.Iterable.Shuffle` Iterable reads all the input data at once
into an array and shuffles the order.

    var d = [1, 2, 3];
    var i = Rosella.Query.iterable(d)
        .shuffle();

### Query.Iterable.Sort

A `Rosella.Query.Iterable.Sort` Iterable reads all the input data at once
into an array and sorts the data. The Sort Iterable can take an optional
sorting comparer function. A Comparer should take two arguments. It should
return `-1` if the first is less than the second, `0` if the two are equal or
equivalent, or `1` if the first is greater than the second.

    var d = [1, 2, 3];
    var i = Rosella.Query.iterable(d)
        .sort();

    var j = Rosella.Query.iterable(d)
        .sort(function(a, b) {
            if (a > b) return 1;
            if (a < b) return -1;
            return 0;
        });

The `Rosella.Query.Sort` namespace provides several ready-made comparers:

    var f = Rosella.Query.Sort.get_default_comparer();
    f = Rosella.Query.Sort.get_reverse_comparer();
    f = Rosella.Query.Sort.get_unmoving_comparer();
    f = Rosella.Query.Sort.get_randomizing_comparer();

    var i = Rosella.Query.iterable(d)
        .sort(f);

### Query.Iterable.Source

`Rosella.Query.Iterable.Source` is the abstract parent class of various source
iterables such as Array, Hash and Iterator. It provides the special API and
default method implementations needed by these types.

### Query.Iterable.TakeSkip

The `Rosella.Query.Iterable.TakeSkip` Iterable implements the `take` and `skip`
behaviors of Iterable.

    var d = [1, 2, 3, 4, 5, 6];
    var i = Rosella.Query.iterable(d)
        .skip(2)
        .take(2); // [3, 4]

### Query.Iterable.Tap

The `Rosella.Query.Iterable.Tap` Iterator performs a callback on each data item
in the sequence. The data is returned without modification.

    var d = [1, 2, 3, 4, 5, 6];
    var i = Rosella.Query.iterable(d)
        .tap(function(x) { say(x); });

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

### Query.Provider.Factory

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
methods on Queryable return the same Queryable with the new results set, so
operations can be neatly chained together.

The best way to get a Queryable for your data is to use the
`Rosella.Query.as_queryable` function.

The `.data()` method returns the data object stored inside the Queryable.

## Examples

### Winxed

    var rosella = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("query");

This example, from the test suite, uses `.map`, `.filter` and `.fold`. It uses
map to square each entry. Then it uses filter to select only the odd squares.
Finally, it uses fold to sum all the squares together. The sum of 1 + 9 + 25
+ 49 + 81 = 165.

    var data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    int sum = Rosella.Query.as_queryable(data)
        .map(function(int i) { return i * i; })
        .filter(function(int j) { return j % 2; })
        .fold(function(int s, int i) { ret s + i; })
        .data();
    say(sum); # 165

### NQP-rx

    my $rosella := pir::load_bytecode__ps("rosella/core.pbc");
    Rosella::initialize_rosella("filesystem");

Same sum-of-odd-squares example from above, in NQP-rx:

    my @data := [1, 2, 3, 4, 5, 6, 7, 8, 9];
    my $sum := Rosella::Query::as_queryable(@data, 1).map(
        -> $i { $i * $i; }
    ).filter(
        -> $j { $j % 2; }
    ).fold(
        -> $s, $i { $s + $i; }
    ).data;
    pir::say($sum); # 165

## Users

* The Rosella Harness library uses the Query library, specifically Streams,
in executing tests and parsing through the output.
* The Rosella Template library uses streams of tokens for parsing template
text
