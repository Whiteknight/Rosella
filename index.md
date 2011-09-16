---
layout: rosella
title: Rosella Library
---

Rosella is a library of patterns and practices for use with the Parrot Virtual
Machine. The Rosella project is actually a collection of several individual
libraries, each of which implements a single pattern, best practice or
toolset. Rosella is intended to be used piece-wise. Use only the parts you
want and ignore the parts you do not want. Rosella libraries tend not to be
interdependent, although some of the more advanced libraries rely on some of
the more basic ones.

## Project Goals

The Rosella project has a number of driving goals which influence both the
types of libraries which are provided and the way those libraries are
implemented:

* **Portability**. Rosella is pure-parrot, and has no components written in C.
  It has no runtime dependencies besides a minimally-configured Parrot.
  Rosella can go anywhere Parrot can go.
* **Complete language agnosticism**. Rosella intends to be usable from
  programs written in any language running on Parrot.
* **Encapsulate low-level details**. Parrot provides lots of tools, though
  many are too low-level. Rosella attempts to encapsulate some ugly details
  behind nice, friendly, and usable interfaces.
* **Extensibility**. Rosella aims to provide good defaults, but also to allow
  aggressive modifications, configurations, and subclassing behaviors to those
  who need something different.
* **Provide well-known tools**. Rosella isn't an experimental research
  project. It aims to provide Parrot implementations of well-known patterns,
  practices, architectures, and tools. Rosella borrows good ideas from
  well-known and high-quality sources.
* **Focus on the user**. Rosella is interested in making things easier for
  other coders. It wants to provide things that other coders will actually use
  and appreciate. Rosella is a set of tools for coders, not for end users.
* **Future Proof**. Rosella provides interfaces, sometimes for very simple
  features or algorithms. In the future when Parrot changes or adds new
  features, Rosella will insulate the user from them. When Parrot adds proper
  threading, Rosella will be updated to provide thread-safety where needed.

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

#### [Event](/Rosella/libraries/event.html)

The Event library provides a subscribe/publish system to aide in aggressive
application decoupling. Event publishers can be unaware of the details of
event subscribers, and vice-versa. Applications become easier to maintain
because important communication pathways do not need to have hard-coded
senders and receivers.

#### [FileSystem](/Rosella/libraries/filesystem.html)

The FileSystem library provides a friendly interface for working with the
filesystem. It provides object types for files and directories and a number
of utilities for working with each.

#### [Harness](/Rosella/libraries/harness.html)

A companion to the Test library, The TAP Harness library
implements the logic necessary to quickly construct a TAP harness
for executing unit tests and reporting the results. Rosella's own
test harness is written using this library.

#### [Memoize](/Rosella/libraries/memoize.html)

The Memoize library adds in functionality to add memoization and caching to
subroutines. There is a simple version and a version which uses proxies to add
more features, but is slower.

#### [Mock Object](/Rosella/libraries/mockobject.html)

The MockObject library uses the Rosella Proxy library to implement
full-featured mock objects for use in testing with the Test
library. Several tests in the Rosella test suite are implemented
using this library.

#### [Path](/rosella/libraryes/path.html)

The Path library provides utilities for searching the contents of large nested
aggregate objects using string names.

#### [Proxy](/Rosella/libraries/proxy.html)

The Proxy library provides the tools necessary to create a wide
array of proxy objects.

#### [Query](/Rosella/libraries/query.html)

The Query library provides a number of utilities for working with aggregate
objects including higher-order functions, group operations, and data streams.

#### [String](/Rosella/libraries/string.html)

The String library provides a number of utilities and powerful interfaces for
working with strings.

#### [Test](/Rosella/libraries/test.html)

Inspired by testing libraries such as xUnit and Test::More,
The Rosella Test library provides the tools and utilities to
quickly write unit tests for your software. Rosella's own test
suite is written using this library.

#### [Template](/Rosella/libraries/template.html)

The Template library provides an engine for text templating tasks.

#### [Winxed](/Rosella/libraries/winxed.html)

The Winxed library contains a number of tools for building Winxed-based
projects.

### Rosella Development Libraries

Rosella has a number of other libraries in planning and development. These
libraries are not yet considered mature enough to include as part of a
regular release. For the complete list with descriptions and ideas, see the
[future libraries page](/Rosella/libraries/future.html).

## Install

### Build Dependencies

* [Parrot](http://github.com/parrot/parrot) : Rosella runs on top of the
  Parrot VM. You cannot build, run, or use Rosella in any way without Parrot.
* [Winxed](http://code.google.com/p/winxed) : Rosella is written in the
  Winxed language. You need Winxed to build Rosella, but you do not need
  Winxed to run it. Winxed has no runtime libraries of its own.

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

