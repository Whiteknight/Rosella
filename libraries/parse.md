---
layout: rosella
title: Rosella Parse
---

## Overview

The Rosella Parse library is a basic utilities library for doing codepoint-level
parsing on strings without the need to repeatedly take string indices and
substrings. It has three components:

* `rosella/parse.pbc` The parse library bytecode
* `Rosella/Ascii.winxed` The winxed include file with various defined constants
  and macros (For use with Winxed only).
* `Rosella/Parse_builtins.winxed` The winxed include file with various defined
  macros for performing parse operations. (For use with Winxed only).

In addition, when using the macros, the `Rosella/Builtins.winxed` include file
may be useful because it contains several macros that may be used to help with
parsing tasks.

The intention is for this library to be equally effective for strings in all
encodings. Currently, ASCII is best supported with Latin1 and UTF8 next.
Support for non-ascii encodings will be improved over time.

## Concepts

* **Codepoint** A codepoint is the unique integer representation of a single
  character. In ASCII strings a codepoint is a 7 bit quantity. In extended or
  multibyte strings, a codepoint may be any integer value.

## Namespaces

### Rosella.Parse

The Rosella.Parse namespace contains all the parsing utilities.

`setup_parse` takes a string and returns the various stuctures and values needed
for efficient parsing:

    :(string str, var s, var b, int len) = Rosella.Parse.setup_parse(my_string);

These 4 return values are passed to almost all subsequent parsing routines.
These values are:

* `str` The string to be parsed.
* `s` The lookahed stack
* `b` The string iterator
* `len` The total number of codepoints in the string

Here is a list of some of the routines in Parse:

* `setup_parse`: Sets up the parse, returns the structures listed above
* `parse_quoted`: Parse a quoted string. The first quote should already be read
  and passed as the first argument
* `parse_string` : Parse a quoted string, following normal C-style escape
  sequences. The first quote should already be read and passed as the first
  argument.
* `parse_alphanumeric`: Parse an alphanumeric identifier
* `parse_alpha`: Parse a character sequence
* `parse_number`: Parse a floating point number. The first character has already
  been read and passed as the first argument. Returns the float.
* `parse_hexadecimal`: Parse a hexadecimal integer value. Return the integer.
* `parse_octal`: Parse an octal value. Return the integer.
* `parse_integer`: Parse a base-10 integer. Return the integer.
* `parse_until`: Retrieve all characters until either the provided marker value
  or the end of the string. Return the result string and the given marker value.
  If the end of string was reached, return 0 as the marker.
* `parse_until_either`: Retrieve all characters until either of two provided
  marker values or the end of string, whichever is first. Return the found
  marker value if one of those was found, 0 if the end of string was reached
  first.
* `parse_remainder` : Return the remainder of the string
* `parse_repeat`: Parse a sequence of a single character repeated. Returns the
  number of times the character occured (including the first one, passed as the
  first argument).
* `error_unknown_char`: Throw an error when an unexpected character or
  unexpected end of string is found.

## Winxed Include Files

### Rosella/Parse.winxed

The basic include file for Parse. Loads the parse bytecode and provides forward
declarations of the various namespaces and functions provided by the library.

### Rosella/Ascii.winxed

An include file with declarations of various ASCII characters and a handful of
macros for working with ASCII characters.

### Rosella/Parse_Builtins.winxed

And include file with declarations of various macros for parsing strings of any
encoding.

## Examples

### Winxed

### NQP-rx

## Users

* Rosella Net uses Parse for parsing URI strings and other inputs
* Rosella Xml and Json use Parse for parsing duties
