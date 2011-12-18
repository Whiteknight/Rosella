---
layout: rosella
title: Rosella String
---

## Overview

The Rosella String library provides a number of tools and utilities for
working with strings and text in Parrot. It serves two purposes: First, to
provide easy access to several important string-handling routines and Second,
to provide an abstraction layers over details of the strings system which
might not be good to rely upon directly.

## Concepts

### Character Classes

Character classes are numeric identifiers that represent certain types of
characters in a string. Parrot defines a list of these identifiers for things
like "word", "whitespace", "alphabetic", "numeric", "punctuation" and other
classes. Several routines in the String library work with these identifiers
for identifying characters of a particular type in a string. Parrot works with
character classes using a set of named integer values. Rosella adds the
ability to look up these class identifier numbers by name.

### Tokenizers

Tokenizers break a sequence of input data into into a stream of objects called
Tokens. Each Token contains the segment of the input data that generated it,
a type name, and arbitrary metadata.

Tokenizers are lazy and support several semantics which would be useful for
building higher-level utilities such as lexical analyzers, parsers, and other
types of programs. The String library ships with a few simple types of
tokenizers. Additional functionality can be easily added by subclassing
`Rosella.String.Tokenizer`.

## Namespaces

### Rosella.String

The Rosella.String namespace provides a number of utility methods for working
with strings. Many of these utilities are thin wrappers around existing
functionality found in built-in Parrot PMC types and opcodes. However, this
functionality is not always exposed, or exposed cleanly, from all HLLs. Also,
the interfaces for some of these behaviors are not always consistent or
familiar to coders of higher-level languages.

Here are some examples of string utilities:

    i = get_character_class("whitespace");  # Get the CClass ID for "whitespace"
    s = trim_start("   test");  # "test"
    s = trim_end("test    ");   # "test"
    s = trim("   test   ");     # "test"
    s = pad_start("test", 6);   # "  test"
    s = pad_end("test", 6);     # "test  "
    s = replace("banana", "a", "X");    # "bXnXnX"

Rosella also provides selected metrics which compare two strings. One of the
provided algorithms is the Levenshtein distance `String.distance(s1, s2)`.
The Levenshtein distance between two strings is defined as the minimum number
of edits needed to transform one string into the other, with the allowable edit
operations being insertion, deletion, or substitution of a single character.

A quick example of the function and return values:

    i = distance("purl", "perl");       # 1
    i = distance("Saturday", "Sunday"); # 3 (Saturday -> Sturday, Sturday -> Surday, Surday -> Sunday)
    i = distance("kitten", "sitting");  # 3 (kitten -> sitten, sitten -> sittin, sittin -> sitting)
    
## Functions

### String.distance

The String.distance function provides a simple implementation to compute the
Levenshtein distance between two strings.

An example of

## Classes

### String.Tokenizer

`Rosella.String.Tokenizer` is the abstract base type for tokenizers in the
String library. It provides some basic functionality for breaking a string
into a sequence of tokens, and working with those tokens.

Do not use this class directly. Use subclasses of Tokenizer instead.

### String.Tokenizer.CClass

`Rosella.String.Tokenizer.CClass` is a Tokenizer class which breaks a string
up into sequences by character class codes. The user can specify which classes
to search for. The tokenizer will return sequences of characters which all
share a common character class. Characters which do not correspond to a
specified character class are returned individually with null metadata.

By default, the CClass Tokenizer searches for "whitespace" and "word" classes.
Here's a quick example of how this is used:

    my $t := Rosella::construct(Rosella::String::Tokenizer::CClass);
    $t.add_data("foo bar baz");
    my $c := $t.get_token;      # "foo"
    $c := $t.get_token;         # " "
    $c := $t.get_token;         # "bar"
    $c := $t.get_token;         # " "
    $c := $t.get_token;         # "baz"

Whitespace is preserved because it is like any other character class.

### String.Tokenizer.Delimiter

`Rosella.String.Tokenizer.Delimiter` is a simple tokenizer type that uses a
delimiter sequence to break an input string into a sequence of tokens. For
instance, a comma-separated-values (CSV) file can typically be parsed with
a simple Delimiter tokenizer:

    my $t := Rosella::construct(Rosella::String::Tokenizer::Delimiter, ",");
    $t.add_data("foo,bar,baz");
    my $c := $t.get_token;      # "foo"
    $c := $t.get_token;         # "bar"
    $c := $t.get_token;         # "baz"

The biggest difference between the Delimiter tokenizer and the simple built-in
`split` opcode is that the tokenizer is lazy and does not create tokens until
asked.

### String.Tokenizer.DelimiterRegion

`Rosella.String.Tokenizer.DelimiterRegion` is a Tokenizer that breaks an
input sequence into regions using delimiter start/end pairs.

    my $t := Rosella::construct(Rosella::String::Tokenizer::DelimiterRegion, "Text");
    $t.add_region("{", "}", "Brackets");
    $t.add_region("[", "]", "Braces");
    $t.add_region("(", ")", "Parenthesis");
    $t.add_data("This { is } a [bit] of (sample) text");
    my $r := $t.get_token; say($r.type_name ~ ": " ~ $r.data);
    $r := $t.get_token; say($r.type_name ~ ": " ~ $r.data);
    $r := $t.get_token; say($r.type_name ~ ": " ~ $r.data);
    $r := $t.get_token; say($r.type_name ~ ": " ~ $r.data);
    $r := $t.get_token; say($r.type_name ~ ": " ~ $r.data);
    $r := $t.get_token; say($r.type_name ~ ": " ~ $r.data);
    $r := $t.get_token; say($r.type_name ~ ": " ~ $r.data);

The output to the above code would be:

    Text: this
    Brackets: is
    Text: a
    Braces: bit
    Text: of
    Parenthesis: sample
    Text: text

This can be extremely handy when you are working with text markup languages
like HTML, XML, Wikitext or Markdown.

### String.Tokenizer.Iterator

`Rosella.String.Tokenizer.Iterator` is a simple iterator type which allows
the contents of a Tokenizer to be iterated.

### String.Tokenizer.Token

`Rosella.String.Tokenizer.Token` is the data object returned from a Tokenizer.
It has three data fields: `data` is the piece of string matched by the
tokenizer, `type_name` is the name of the token, if available, and `metadata`
is a storage slot for arbitrary metadata to be attached.

Different tokenizers will populate the name and metadata fields differently.
For instance, the CClass tokenizer will add the integer character class
identifier as the token metadata. The simple Delimiter tokenizer populates
neither the name nor the metadata fields in the tokens.

## Examples

### Winxed

    var rosella = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("string");

    var t = new Rosella.String.Tokenizer.CClass();
    t.add_data("1234+*&^abcd");
    for(string s in t)
        say(s);

### NQP

## Users

* The Rosella Template library uses String for tokenization and string
manipulation needs.
