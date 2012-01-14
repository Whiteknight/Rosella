---
layout: rosella
title: Rosella Date
---

## Overview

The Rosella Date library provides an immutable Date type for representing
dates and times. It provides a handful of utilities for working with Date
objects as well.

## Concepts

## Namespaces

### Rosella.Date

The `Rosella.Date` namespace contains a number of utility functions for working
with Date objects.

    var d = Rosella.Date.now();
    var m = Rosella.Date.min();
    var m = Rosella.Date.max();
    string day = Rosella.Date.get_day_of_week_name(2012, 1, 14);
    int y = Rosella.Date.is_leap_year(2012);

## Classes

### Rosella.Date

`Rosella.Date` objects are the default class for working with dates and times.

### Rosella.Date.DateFormatter

`Rosella.Date.DateFormatter` is a StringFormatter type specially designed for
Date objects. It takes a format string with identifiers such as "yyyy" (year),
"MM" (month), "dd" (day), "hh" (hour), "mm" (minute), "ss" (second) and
replaces those values in the string with the corresponding values from the
Date object.

You can use this type directly or you can call the `.format_string()` method
on the Date object.

### Rosella.Date.SpecialDate

`Rosella.Date.SpecialDate` are special date objects which represent values which
aren't necessarily real dates.  This is an abstract parent type and should not
be used directly.

### Rosella.Date.SpecialDate.Minimum

`Rosella.Date.SpecialDate.Minimum` is a special singleton value which represents
a guaranteed minimum date. Minimum dates are always guaranteed to be compared
less than all other dates, and is equal only to itself.

### Rosella.Date.SpecialDate.Maximum

`Rosella.Date.SpecialDate.Maximum` is a special singleton value which represents
a guaranteed maximum date. Maximum dates are always guaranteed to be compared
greater than all other dates, and is equal only to itself.

## Examples

### Winxed

    var d = new Rosella.Date.now();
    say(d.format_string("It is yyyy-MM-dd at exactly hh:mm:ss"));

### NQP-rx

## Users
