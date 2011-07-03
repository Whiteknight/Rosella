---
layout: rosella
title: Rosella String
---

## Overview

The Rosella String library provides a number of tools and utilities for
working with strings and text in Parrot.

## Concepts

### Character Classes

Character classes are numeric identifiers that represent certain types of
characters in a string. Parrot defines a list of these identifiers for things
like "word", "whitespace", "alphabetic", "numeric", "punctuation" and other
classes. Several routines in the String library work with these identifiers
for identifying characters of a particular type in a string.

### Tokenizers

Tokenizers break a sequence of input data into into a stream of objects called
Tokens. Each Token contains the segment of the input data that generated it,
a type name, and arbitrary metadata.

Tokenizers are lazy and support several semantics which would be useful for
building higher-level utilities such as lexical analyzers, parsers, and other
types of programs.

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

### String.Tokenizer.Token

`Rosella.String.Tokenizer.Token` is the data object returned from a Tokenizer.
It has three data fields: `data` is the piece of string matched by the
tokenizer, `type_name` is the name of the token, if available, and `metadata`
is a storage slot for arbitrary metadata to be attached.

## Examples

### Winxed

### NQP

## Users

