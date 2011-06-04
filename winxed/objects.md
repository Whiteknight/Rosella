---
layout: rosella
title: Objects
---

## Creating Objects

### init_pmc VTABLEs

Parrot provides a vtable called init_pmc which can be used to initialize an
object at the lowest level during object allocation. init_pmc takes a single
PMC argument, which can be passed in using the bracketed form of the `new`
keyword:

    class Foo {
        function init_pmc[vtable](var pmc) {
            ...
        }
    }

    function create_foo(var init) {
        var foo = new ['Foo'](init);
        return foo;
    }

In this example the Foo class defines an init_pmc vtable override which is
called by Parrot when the `new` operator executes. This is a low-level
approach to initialization and has a number of flaws. If possible, or unless
an exceptional need presents itself, try not to use this mechanism for your
own types. For some of Parrot's lowest level built-in types this is the only
way to initialize them, but you are writing code in Winxed and you have other
options.

As an aside, Parrot also provides an init vtable, which initializes a new PMC
without taking an argument. Parrot decides which to call depending on whether
or not an argument was passed to the `new` opcode at the Parrot level.
Following the example above, we can call the init VTABLE instead of init_pmc
if we allocate foo without parenthesis or an argument:

    class Foo {
        function init_pmc[vtable](var pmc) {
            ...
        }

        function init[vtable])_ {
            ...
        }
    }

    function create_foo(var init) {
        var foo = new ['Foo'];  // Calls init, not init_pmc
        return foo;
    }

init VTABLE is called every time Parrot allocates an object. It is usually
transparent and has no effect. The only time this information matters is if
you want to instead use init_pmc, or if you want to add in some kind of
initialization logic in init. If you provide a version of it in your code as
a `[vtable]`, that will be called *before* a Constructor. Typically this is a
low-level detail that you shouldn't be playing with for a variety of reasons.
However, if you absolutely need to perform initialization before calling a
constructor or perform initialization that might alter the dynamic dispatch
of the constructor, init is a handy tool to use. Try to avoid it if you can,
but be aware that it is available.

### Constructors

Winxed defines a constructor as any method which has the same name as the
short name of the Class. So if we define a `class Foo { }`, the function
`function Foo() { }` is the constructor for it.

If we use the `new` keyword with the name of the class (without brackets) we
can create a new object of that type:

    var foo = new Foo;

Notice two things. First, this statement does not invoke the init_pmc vtable
(but it does automatically invoke the init vtable). Second, we do *not* invoke
the Foo class contructor. To invoke the constructor, you need to use
parenthesis:

    var foo = new Foo();

If your class is nested inside a namespace, you use the namespace to specify
the full name of the Class. The constructor is still the Class shortname:

    namespace Bar {
        class Foo {
            function Foo() {
                ...     // Constructor
            }
        }
    }

    function get_a_foo() {
        var foo = new Bar.Foo();
    }

In this example, the class is named Foo so the constructor is named Foo.
However, Winxed needs to look up the class using the namespace path `Bar.Foo`.

### Creating Objects Review

Here are some common scenarios for allocating a PMC, and what effect they
have:

    var f = new Foo.Bar.Baz;

This creates a new object of type `Baz`, which Winxed will look up in the
Foo.Bar namespace. This calls init VTABLE, but does not call a constructor.
This form of the allocation will cause Winxed to display a warning if
Foo.Bar.Baz cannot be located at compile time (if it is defined in a
dynamically-loaded library, for instance).

    var f = new Foo.Bar.Baz();

This is the same as the example above but it also automatically invokes the
constructor `Baz()` on the object as soon as it is allocated. This calls the
init VTABLE first, before the constructor. Notice that this will throw a
method not found exception if the constructor does not exist.

    var f = new ["Foo", "Bar", "Baz"];

This creates a new Foo.Bar.Baz object using the lower-level syntax. It invokes
the init VTABLE but no constructor. This form does not cause Winxed to display
a warning if the type is not found at compile time.

These two invocations are the same:

    var f = new "Foo";
    var f = new ["Foo"];

Notice that the first form does not use brackets but can also not be used with
namespaces or nested classes. The first form without brackets is commonly used
to allocate new built-in Parrot types, because they are not namespaces and
do not have Constructors in the way Winxed defines the term.

    var f = new ["Foo", "Bar", "Baz"](p);

This creates a new Foo.Bar.Baz calling the init_pmc VTABLE with value `p`. It
does not call the constructor and does not issue a warning at runtime. Notice
that for both of the lower-level calls you can always call the constructor
explicitly:

    var f = new ["Foo", "Bar", "Baz"](p);
    f.Baz(args);

Notice also that we can use the more simple form with init_pmc:

    var f = new "Foo"(p)

## Examining Objects

### typeof

Classes are objects. We can get the Class from an object using the `typeof`
builtin:

    var my_class = typeof(x);

### instanceof

The `instanceof` operator is used to check if an object is a member of a
certain class.

    if (x instanceof Foo.Bar.Baz) { ... }
    if (x instanceof ["Foo", "Bar", "Baz"]) { ... }

The `instanceof` keyword cannot currently be used to check if a var is a
member of a class using a class reference:

    var x_class = typeof(x);
    if (x instanceof x_class) { ... }   // Parse fail.

To work with class instance objects, you need to use the PIR `isa` opcode:

    var x_class = typeof(x);
    int isa_x_class = 0;
    ${ isa isa_x_class, x, x_class };
    if (isa_x_class) { ... }

### Playing with the Class

Parrot provides a number of methods on the default Class object for examining
and altering the methods and attributes of a class, for instantiating new
objects from the class object reference, or altering the inheritance hierarchy
of the class at runtime. Be careful in making alterations to a class: Some
alterations such as the inheritance hierarchy cannot be changed after the
class has been instantiated for the first time. Also, changing things like the
available methods and the available attributes may have weird effects on
existing objects. This is because objects typically cache details about
methods and attributes after they are created. You can end up with objects
of the same class which have different sets of attributes, different sets of
methods, or whose methods have different behaviors.

### Object Roles and Capabilities

Similarly to our `isa` examples above, we can determine if a var implements
a particular role, or if it can perform certain methods with `does` and `can`
respectively.

    // Detect if an object is an array
    int does_array = 0;
    ${ does does_array, x, "array" };
    if (does_array) { ... }

    // Detect if an object is a hash
    int does_hash = 0;
    ${ does does_hash, x, "hash" };
    if (does_hash) { ... }

    // Determine if the object is a Sub, or a Sub-like invokeable object
    int does_invoke = 0;
    ${ does does_invoke, x, "invokable" };
    if (does_invoke) { ... }

The `does` opcode falls back to the "does" vtable. All Parrot built-in types
are properly marked with certain roles: "array" for arrays and array-like
objects which can be indexed by number, "hash" for hashes and hash-like
objects which can be indexed by string, "invokable" for Subs and objects that
can be invoked, etc. If you want to create a custom type that can be used in
place of these built-in types you probably want to add an override for the
"does" vtable in your class:

    function does[vtable](string role) {
        if (role == "array")
            return 1;
        return 0;
    }

Here is a wrapper class that wraps a Sub to perform error-checking on the
inputs to ensure non-null:

    class SubWithNonNullArguments {
        var sub;
        function SubWithNonNullArguments(var s) {
            self.sub = s;
        }

        function does[vtable](string role {
            return (role == "invokable");
        }

        function invoke[vtable](var p [slurpy]) {
            for (var item in p) {
                if (item == null)
                    die("Arguement cannot be null!");
            }
            var s = self.sub;
            return s(p:[flat]);
        }
    }

Here we provide a class that overrides the "does" vtable to pretend to be
a Sub, and overrides the "invoke" vtable to handle the actual call. Inside the
"invoke" vtable we slurpy up all the arguments into a single array, loop over
them to check for null, and then pass the flattened list to the original
subroutine. This is a pretty powerful, and pretty common kind of idiom, and
you see it done in many places where we need to add a wrapper around one
routine so that the internal routine does not know it has been wrapped. We'll
see more examples of this later.

In addition to the "does" opcode and vtable, we can use the "can" opcode to
determine if an object has certain methods. The "can" opcode uses the
"find_method" vtable internally to search for a method of the given name. If
"find_method" returns null, can returns 0. Winxed has a find_method built-in
which calls the  "find_method" PIR op internally. The difference between
"find_method" and "can" ops at the PIR level is that the "find_method" op
throws an exception if the method does not exist, while "can" returns a
boolean result.

    int can_do = 0;
    ${ can can_do, x, "foobar" };
    if (can_do) {
        say("X can foobar!");
        x.foobar(...);
    } else
        say("X can not foobar :(");

Here is the same kind of sequence using the find_method builtin:

    var foobar = null;
    try {
        var foobar = find_method(x, "foobar");
        say("X can foobar!");
    } catch {
        say("X can not foobar :(");
    }
    if (foobar != null)
        x.*foobar(...);

It's a similar amount of code, but setting exception handlers is much more
expensive of an operation than the "can" opcode is. The reason why the
invocation of the foobar method is pulled out of the try/catch block is
because if the foobar method throws an exception we will get both messages.
We want to separate out searching for the method from actually invoking the
method, and handle the errors separately.

We haven't seen the try/catch syntax before. We'll look at those in more
detail later.

## Null and Definedness

