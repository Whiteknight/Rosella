---
layout: rosella
title: Rosella Core
---

## Overview

The Rosella Core library is the central component library of Rosella. It is
a dependency of all other Rosella libraries and provides a small amount of
basic functionality required by all the other libraries.

The Rosella Core library is mostly concerned with creating and initializing
new objects in a standard way. These mechanisms are used throughout the
Rosella codebase, and are expected to be used by user code creating objects
from the Rosella library.

The Core library is automatically included in all other Rosella libraries.
When using a Rosella library you do not need to include Core, the other
libraries will include it for you automatically. You only need to explicitly
include Core in your project if you aren't using any other Rosella libraries
and you want the features from the Core library.

## Concepts

### Type Keys

Type keys are objects which either are, or can refer unambiguously to, a
Parrot Class. Anywhere Rosella accepts a "type", it can be one of:

* A Class PMC
* A Namespace PMC
* A Key PMC
* A ResizableStringArray PMC
* A string or String PMC
* A P6protoobject Object
* A P6metaclass Object

Any other PMC passed will be stringified to get the name, and that name will
be treated like a String.

### Constructors

By default, Parrot objects do not have anything that could be considered a
real "constructor". That is, there is no standard mechanism through which a
new object can be initialized with a set of default or invariant data.

Rosella provides this mechanism, and allows constructors to be defined in
classes using one of two different formats:

1. A method named BUILD (The "Perl6 Style")
2. A method with the same short name as the class (The "Winxed Style")

The Rosella library itself uses the Winxed Style of constructors internally,
but mechanisms are provided for user code to do differently if needed.

### Problems with Constructors

The `alloc`, `build` and `construct` functions in the Rosella namespace are of
key importance. Most languages do provide mechanisms for allocating objects
and executing constructors. However, objects which are from alternate object
models, or objects which do not conform to the constructor semantics of the
currently executing HLL may break when used.

For example, a common constructor sequence in an HLL may look something like
this:

    foo = new Bar.Baz(...args...)

This, in a naive compiler, could translate to something like this PIR code
snippet:

    foo = new ["Bar";"Baz"]
    $P0 = get_hll_global ["Bar";"Baz"], "<ctor>"
    foo.$P0(...args...)

Where, of course, "`<ctor>`" is the name of whatever the constructor is
expected to be called. In Perl6ish languages, maybe this is "BUILD". In
languages descended more from the C++ tradition, it may be "Baz" named after
the short name of the class it is in. In yet other languages it may be
something like "__init__", or ".ctor", or something else.

What's important to note here is that there is no easy, common, low-level way
to ask a type what constructor to use, if any. Parrot does allow for an
initialization parameter which can be used as an extra argument to the `new`
opcode, and that parameter might be able to be used by an object system to
execute a constructor. However, so far the many Parrot HLL object models do
not agree to use this in a consistant manner.

What the Rosella `build` and `construct` functions do is provide an
abstraction layer, which creates a consistant mechanism for creating and
initializing objects. Ultimately this mechanism may become unnecessary if
Parrot's future object model provides a more robust and common way for dealing
with constructors.

Different languages may also use different types of lookup keys to reference
a Class to create. For instance, NQP will typically use a P6protoobject or
a Parrot NameSpace PMC to refer to a type, depending on which point in the
program initialization you are in. A Winxed program may use a String or a
Key.

Rosella's object building utilities provide two things:

1. *Consistancy of constructor logic*. If you use `Rosella.build`, it will
   always attempt to call the BUILD method, if available. If you use
   `Rosella.construct`, it will always try to call a constructor with the same
   short name as the class. This is independent of the environment where the
   call is being made. Rosella may eventually provide other mechanisms for
   other HLLs as well.
2. *Flexibility of Type Specifiers*. Rosella accepts multiple different forms
   of type specifier, any of which can be used to refer to an underlying
   Parrot Class, and can therefore be used to create new objects.

### Global Instance Registry

Rosella contains a global instance registry. This is a globally-visible hash
which can be used to store instances of objects that need to be kept available
for components to use repeatedly. This is a mechanism which is typically only
used by the various Rosella libraries themselves to store certain persistant
data values.

This mechanism is not necessarily designed for user code to use directly.
Where it is necessary to use this functionality to override default behavior
in various libraries, specific interfaces for that will be provided.

Register a global instance:

    using Rosella.Globals.register_global;
    register_global("name", value);

    using Rosella.Globals.get_global;
    var foo = get_global("name");

### Bytecode Loading

Rosella provides several utilities for working with bytecode files in Parrot.

    var rosella = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("action", "container", "test");

Before using Rosella or any of its component libraries, you need to initialize
it. The snippet above loads the Rosella bytecode file, initializes, and
loads the component libraries "action", "container", and "test".

To load a rosella library at runtime, use:

    using Rosella.load_rosella_library;
    load_rosella_library("proxy");

To load any arbitrary bytecode library, use:

    using Rosella.load_bytecode_file;
    var pf = load_bytecode_file("foo/bar.pbc");

If you want to execute all `:load` functions when you load the library, you
must specify it:

    using Rosella.load_bytecode_file;
    var pf = load_bytecode_file("foo/bar.pbc", "load");

## Namespaces

### Rosella

The Rosella namespace provides a number of mechanisms for working with type
keys.

* `alloc`: Instantiate a new object from the type key
* `build`: Instantiate and BUILD (Perl6 Style) a new object from the
        type key, with arguments
* `construct`: Instantiate and initialize (Normal Style) a new object
        from the type key, with arguments
* `get_type_name`: Get a string which represents the name of the type
* `get_type_class`: Get the Parrot Class PMC associated with the type
* `isa`: Determine if a given object belongs to a type
* `find_named_method`: Find a method on an object by name, null if not found
* `invoke_method`: Invoke a method on an object, either by invokable object
        reference or by name
* `get_version`: Get the version information for individual Rosella libraries,
        by name.

### Rosella.Error

The `Rosella.Error` namespace provides a number of error reporting mechanisms
used internally by Rosella to communicate problems. The most common are:

* `invalid`: Throw a general Rosella error. This is used to communicate most
errors internally.
* `must_subclass`: An error in a parent class where a subclass must be used.
When subclassing an existing Rosella type, find uses of this error and make
sure your subclass provides an implementation of that method.

### Rosella.Globals

### Rosella.IO

The Rosella.IO namespace provides some helper methods for working with IO
related tasks. The method `swap_handles` can be used to replace the standard
input, output and error handles with custom handles. This is used in several
places in the test and harness libraries, and may have more general usefulness
elsewhere.

### Rosella.Parrot

The `Rosella.Parrot` namespace provides a number of utility functions for
interacting with Parrot in standard ways.

    // Get the Parrot config hash
    var h = get_config_hash();

    // Get a backtrace from current location
    var bt = get_backtrace_strings();

    // Get a backtrace from the exception object
    var bt = get_backtrace_ex_strings(exception);

    // Execute code. If there is an exception, print the exception details
    // and complete backtrace to the console.
    try_report(function() {
        ...
    });

### Rosella.Version

Rosella libraries are individually versioned. To get the version information
for a Rosella library, you can use the `Rosella.Version.get_version` function.
This function returns a simple version object which contains acessors to get
detailed version information.

    var v = Rosella.Version.get_version("core");
    say(v.library_name());
    say(v.library_version());
    say(v.library_state());

The `library_version` is a version number. Libraries with version number 0
are considered "unstable" or are early prototypes. The `library_state` is an
identifier like "alpha", "beta", or "stable" which tells the state of the
library.

## Classes

### Rosella.ObjectFactory

The ObjectFactory class is a Factory type which can be used to build objects
from a given type key. Object factory defines two methods, `create` and
`create_typed`.

ObjectFactory can be constructed with an optional type object, which becomes
its default type. If a default type is provided in the constructor,
`ObjectFactory.create` returns a new object of the default type. If a default
type is not provided, `ObjectFactory.create` throws an error.

`ObjectFactory.create_typed` creates a new object of the given type,
disregarding the default type of the factory.

ObjectFactory is the parent type of all other factory objects in Rosella.
The basic ObjectFactory has limited utility, but it provides a common
interface for other, more advanced, factory types.

### Rosella.Version

The `Rosella.Version` class is used as the return object from the
`Rosella.Version.get_version` function. It encapsulates version information
from individual Rosella libraries.

## Examples

### Winxed

First, you need to load and initialize Rosella:

    var rosella = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)();

Create an object with BUILD:

    using Rosella.build;
    // Calls obj.BUILD(arg)
    var obj = build(class My.P6ish.Type, arg);

Create an object with a constructor:

    using Rosella.construct;
    // Calls obj.Type(arg)
    var obj = construct(class My.Normal.Type, arg)

### NQP-rx

First, load and initialize Rosella:

    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella();

Create an object with BUILD:

    # Calls $obj.BUILD($arg)
    my $obj := Rosella::build(My::P6ish::Type, $arg);

Create an object with a constructor:

    # Calls $obj.Type($arg)
    my $obj := Rosella::construct(My::Normal::Type, $arg);

## Users

* All Rosella libraries use the Core library functionality
