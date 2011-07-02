---
layout: rosella
title: Rosella Path
---

## Overview

The Rosella Path library provides the ability to search for values in nested
aggregate objects with a single path string. This string-based recursive
search is useful in situations where we need to decouple the use of a complex
data object from its internal structure.

The Path library provides one class with one method of interest:
`Rosella.Path` and its `get` method. `Path` is an object type that brings
together the logic and state information to perform a search, and the `get`
method performs the search, returning a value.

## Concepts

### Search Strings

Search strings are used to find a value in a nested aggregate. Elements in a
search string are separated by a separator sequence. If we have a value in
a nested hash of hashes, we can find it like this:

    my $r := %data{"foo"}{"bar"};

OR, we can use Path with a single search string with both keys joined by a
separator:

    my $r := $path.get(%data, "foo.bar");

Notice that the Path library avoids the semipredicate problem where a hash
key can contain the separator character:

    my %data := {};
    %data{"foo.bar"} := "hello!";
    my $r := %data{"foo"}{"bar"};       // WRONG! Won't find it
    $r := $path.get(%data, "foo.bar");  // Right! Still works!

Path does a recursive search through the search string itself, splitting at
the separator characters and searching for increasingly long segments of it.

If we have a search string "a.b.c.d", Path will search for the keys in order:

    "a.b.c.d"
    "a.b.c"
    "a.b"
    "a"

Until it finds a match. When it does find a match, it recurses into the result
and continues searching for the remainder of the string. Notice that this is
not optimally efficient. Many combinations may be searched before the value is
found. If you know exactly where the data is located, it is usually much more
efficient to simply fetch it yourself. However, if you do not know where data
may be located, such as is the case with user input, or if the format of the
data is subject to change, the Path library gives you a level of abstraction
to keep your code working.

## Namespaces

None.

## Classes

### Path

The `Rosella.Path` class is the primary actor and the user-visible interface
for the Path library. It holds the state information and user-specified
options for searching for data in a nested aggregate.

    my $p := Rosella::construct(Rosella::Path);
    my $result := $p.get($x, "foo.bar.baz");

### Path.Searcher

`Rosella.Path.Searcher` is the abstract parent class of searcher objects. It
defines an interface that all searchers must implement in order to be used
with the Path object.

Do not use this type directly. Use a subclass instead.

### Path.Searcher.Attribute

`Rosella.Path.Searcher.Attribute` searches an object for attributes of a given
name.

### Path.Searcher.Hash

`Rosella.Path.Searcher.Hash` searches an object using string-keyed hash-like
value lookups.

## Examples

### Winxed

    var data = { "a" : "1", "b" : { "c" : 2 } };
    var p = new Rosella.Path();
    var r = p.get(data, "b.c"); // r = 2

### NQP

    my $q := Rosella::construct(Rosella::Path);
    my $r := $q.get($x, 'foo.bar.$!attr.baz.%!props.fie');

## Users

