---
layout: rosella
title: Rosella Core
---

## Overview

JSON (short for JavaScript Object Notation) is a data serialization format based
on JavaScript object literals. JSON strings are always valid JavaScript code
and should always be able to be parsed by JavaScript compilers.

The Rosella Json library contains utilities for parsing Json strings and
serializing Parrot objects to JSON format.

## Concepts

## Namespaces

### Rosella.Json

The `Rosella.Json` namespace contains most of the high-level driver routines
for working with JSON.

* `parse` : Parse a JSON string and return a Parrot object
* `to_json` : Take a Parrot object and return a string of JSON representing its
  contents.
* `default_builder_factory`: The default ObjectFactory for Builder objects.

### Rosella.Json.Parser

The `Rosella.Json.Parser` namespace contains most of the routines for parsing
a string of JSON. These routines are private and should not be used directly.
Use the `Rosella.Json.parse` function to parse JSON.

## Classes

### Rosella.Json.Builder

An abstract parent class for Builders. A Builder is an object that is used by
the parser to create the Parrot object.

### Rosella.Json.Builder.DataObject

Creates a nested structure of Parrot ResizablePMCArray and Hash PMCs from the
string of JSON.

### Rosella.Json.Builder.Factory

An ObjectFactory type for creating Builder objects.

### Rosella.Json.Dumper

A subclass of Rosella.Dumper for dumping Parrot objects to JSON.

### Rosella.Json.DumpHandler.Array

A DumpHandler for Array-like objects.

### Rosella.Json.DumpHandler.Float

A DumpHandler for floating point numbers.

### Rosella.Json.DumpHandler.Hash

A DumpHandler for Hash-like objects.

### Rosella.Json.DumpHandler.Integer

A DumpHandler for integers.

### Rosella.Json.DumpHandler.Null

A DumpHandler for null.

### Rosella.Json.DumpHandler.Object

A DumpHandler for user-defined objects.

## Winxed Include Files

### Rosella/Json.winxed

## Examples

### Winxed

### NQP-rx

## Users
