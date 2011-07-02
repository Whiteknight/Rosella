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

## Namespaces

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

