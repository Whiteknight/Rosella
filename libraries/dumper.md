---
layout: rosella
title: Rosella Dumper
---

## Overview

Data dumping is a common operation especially during program analysis and
debugging. Rosella Dumper provides utilities to serialize data into a human
readable format and display that data to the user for quick visualization and
analysis of complex nested data structures.

Rosella Dumper is intended to be a debugging tool, and is not intended to be a
general purpose data-serialization library. It might be possible to use it as
such given enough effort and overriding existing behaviors, but a specialized
library for the purpose might be a better option.

## Concepts

## Namespaces

### Rosella.Dumper

The `Rosella.Dumper` namespace provides a function `default_dumper()` which
returns a pre-configured default global Dumper instance.

    var d = Rosella.Dumper.default_dumper();

If you want to override the global default with your own instance, you can do
this:

    var d = < create your dumper here >
    Rosella.Dumper.set_default_dumper(d);

## Classes

### Rosella.Dumper

`Rosella.Dumper` is the main driver class for the dumper library and the primary
user interface. The Dumper holds several different DumpHandler objects, each of
which is responsible for dumping certain objects. The Dumper organizes
DumpHandlers into three groups: role-based handlers, type-based handlers, and
miscellaneous handlers. In addition, there is a fallback handler which is used
to dump any object which has not already been handled by the previous collection
and a Null handler which handles the special case of Null values.

The general algorithm for dumping looks like this:

1. If the data is Null, use the Null Handler
2. Search the type handlers to find one that matches the specific type of the
   data. If found, use that.
3. Search the role handlers to find the first one that matches a role
   implemented by the data object. Use the first one found, if any.
4. Search all the miscellaneous handlers for any that can handle the data
   object. Use the first one found, if any.
5. Use the fallback handler

The user can add or remove handlers in each group to create custom behavior.

The `.dump()` method is the primary interface of the dumper. It creates and
returns a string containing the textual representation of the data. It does not
automatically print the data to the console or any file handle.

### Rosella.Dumper.DumpHandler

The `Rosella.Dumper.DumpHandler` is the default handler type and provides basic
logic for dumping a string representation of the object. This type is the
default fallback dumper, and also serves as the parent type for all other
DumpHandlers.

### Rosella.Dumper.DumpHandler.Array

The `Rosella.Dumper.Dumphandler.Array` handler is used to dump any objects which
implement the "array" role. It prints a list of items from the array surrounded
by square brackets.

### Rosella.Dumper.DumpHandler.Hash

The `Rosella.Dumper.Dumphandler.Hash` handler is used to dump any objects which
implement the "hash" role. It prints each key/value pair, surrounded by curly
brackets.

### Rosella.Dumper.DumpHandler.InspectAttrs

`Rosella.Dumper.Dumphandler.InspectAttrs` is a miscellaneous handler which
can be used to dump the attributes of a user object.

### Rosella.Dumper.DumpHandler.Null

The `Rosella.Dumper.Dumphandler.Null` handler is the default handler for null
values. It prints the string "NULL".

### Rosella.Dumper.DumpHandler.Object

The `Rosella.Dumper.Dumphandler.Object` handler is a miscellaneous handler for
dumping user-defined objects. It prints a string representation of the object
(if any) and the values of the object's attributes, surrounded by parenthesis.

### Rosella.Dumper.Emitter

The `Rosella.Dumper.Emitter` class is the emitter for the library. It is
responsible for building and formatting the text representation, including
recursive calls to the Dumper for nested data objects.

## Examples

### Winxed

    var d = Rosella.Dumper.default_dumper();
    string s = d.dump(my_obj);
    say(s);

### NQP-rx

## Users
