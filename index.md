---
layout: rosella
title: Rosella Library
---

Rosella is a library of patterns and practices for use with the
Parrot Virtual Machine. The goal of Rosella is to provide a
library of building blocks for programmers on Parrot. By having
these tools and components available in a portable, usable way,
programmers should be empowered to create high quality,
maintainable software faster.

The Rosella project is actually a collection of individual
libraries, each of which implements a single pattern or best
practice. Rosella is intended to be used piece-wise. Use only the
parts you want and ignore the parts you do not want. Rosella
libraries tend not to be interdependent, although some of the more
advanced libraries rely on some of the more basic ones.

## Rosella Components

### Rosella Stable Libraries

Here is a list of Rosella's libraries which are currently
considered to be "stable" enough for general use:

#### [Core](/Rosella/libraries/core.html)

Rosella's Core library provides a handful of routines used by
the other Rosella libraries. This library provides basic behavior
for working with an assortment of "type" meta-objects, and for
implementing a standard system of object constructor behavior.

#### [Action](/Rosella/libraries/action.html)

The Action library implements the Command pattern. Sequences of
instructions can be bundled together into an Action object, and
can be invoked later.

#### [Container](/Rosella/libraries/container.html)

The Container library implements a Dependency Injection, Inversion
of Control container type which can be used to help decouple
modules in a program. The Container utilizes the Action library
to setup constructor injection and method injection behaviors
on registered types.

#### [Test](/Rosella/libraries/test.html)

Inspired by testing libraries such as xUnit and Test::More,
The Rosella Test library provides the tools and utilities to
quickly write unit tests for your software. Rosella's own test
suite is written using this library.

#### [TAP Harness](/Rosella/libraries/tap_harness.html)

A companion to the Test library, The TAP Harness library
implements the logic necessary to quickly construct a TAP harness
for executing unit tests and reporting the results. Rosella's own
test harness is written using this library.

#### [Proxy](/Rosella/libraries/proxy.html)

The Proxy library provides the tools necessary to create a wide
array of proxy objects.

#### [Mock Object](/Rosella/libraries/mockobject.html)

The MockObject library uses the Rosella Proxy library to implement
full-featured mock objects for use in testing with the Test
library. Several tests in the Rosella test suite are implemented
using this library.

### Rosella Development Libraries

This is a list of libraries which are still in design or
development phases:

#### Event

The Event library provides a subscribe/observe interface over the
Action library. Multiple parts of a program can anonymously
subscribe to or publish named events. This library is inspired,
in part, by the event aggregation portions of the PRISM practices
library.

#### Prototype

The Prototype library provides facilities for implementing a
prototype-based object model system. Prototypes and object
constructors/initializers can be registered with the library. New
instances can be cloned from the prototype on demand.

#### Query

The Query library provides interfaces for interacting with
aggregate objects. This library provides a series of higher-order
utilities inspired by the .Net LINQ library.

#### Decorate

The Decorate library uses the Proxy library to implement a system
of cheap, efficient type decorators. A decorator allows
transparent passthrough of normal method calls, attribute
accesses, and primitive value operations while allowing the
programmer to inject additional methods and attributes on a
per-object (not per-class) basis.

#### Contract

The Contract library implements logic for "design by contract"
programming mechanisms. You can set up runtime checks for pre-
and post-conditions on method calls, and you can set up assertions
to verify invariant conditions. All the logic in the library can
be disabled once the software has been tested and deployed.

## Install

### Dependencies
<ul>
    <li>[Parrot](http://github.com/parrot/parrot)</li>
    <li>[Winxed](http://code.google.com/p/winxed)</li>
</ul>

### Installing With Plumage

[Plumage](http://github.com/parrot/plumage) is a
package-management program for Parrot. If you have Plumage
and Winxed already installed getting Rosella is a breeze:

    $ plumage install rosella</pre>

That's all there is to it! You now have Rosella. If you don't have
Plumage on your system you'll need to follow the rest of the
instructions below.

### Get the Source

You can download this project in either
[zip](http://github.com/Whiteknight/Rosella/zipball/master) or
[tar](http://github.com/Whiteknight/Rosella/tarball/master) formats.

You can also clone the project with [Git](http://git-scm.com)
by running:

    $ git clone git://github.com/Whiteknight/Rosella

### Installing Manually

Once you have a copy of the source and all the necessary
dependencies you can build, test and install Rosella:

    $ winxed setup.winxed build
    $ winxed setup.winxed test
    $ winxed setup.wixned install

## Project Info

### License

Rosella is released under the terms of the Artistic 2.0 license.
See the LICENSE file in the repo for more details.

### Authors

Rosella is written by [Whiteknight](http://whiteknight.github.com)
(wknight8111@gmail.com). See the CREDITS file in the repo for more details
about contributors and the people and projects which have inspired Rosella.

<div class="footer">
    get the source code on GitHub :
    <a href="http://github.com/Whiteknight/Rosella">Whiteknight/Rosella</a>
    <br/>
    The image of the Crimson Rosella at the top of the page is from
    <a href="http://commons.wikimedia.org/wiki/File:Crimson_Rosella,_Culburra_Beech.jpg">
        D. Gordon E. Robertson on Wikipedia
    </a>. The image is released under the terms of the CC-By-SA-3.0 and/or
    the GFDL licenses.
</div>

