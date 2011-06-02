---
layout: rosella
title: Winxed Documentation
---

# About Winxed

# Building and Running Winxed

Run a file directly:

    winxed myfile.winxed

Compile a file to PIR and PBC:

    winxed -c -o myfile.pir myfile.winxed
    parrot -o myfile.pbc myfile.pir

# Basic Syntax and Types

Winxed syntax is inspired strongly by languages like JavaScript and C++. The
basics of syntax will be mostly familiar to most people. The basic element
of programming Winxed is the statement, and statements are composed of
expressions.

## Basic Types

There are four basic data types in Parrot, and those same four types are
provided for in Winxed. These are `int` (for primitive integers), `float`
(for floating-point numbers), `string`, and `var` (PMC).

Actually, there are two types of types. The first set are the primitive values
which are mentioned above: int, float, string, and var. PMCs, which are the
"var" type, are polymorphic objects. A var can have multiple types, including
types built in to Parrot and types that you define yourself. The first set of
types we will call the "primitive" types. The second set will be called
"object types". `float`, `int`, and `string` primitive types do not have
vtables and do not have methods. `var` objects do have vtables and do have
methods, along with Class metaobjects and other details that we will discuss
later. For now it's enough to know that we have integers, floats, strings, and
"everything else" (var).

### Type Conversions

Primitive types in winxed can automatically convert between themselves. Here
is an example where we automatically convert between a float and the other
primitive types:

    float a = 1.45; // a is 1.45
    int b = a;      // b is 1
    string c = a;   // c is "1.45"
    var d = a;      // d is a Float PMC with value 1.45

We can do explicit type conversions with casts:

    int a = int(1.45);
    float b = float("3.14");
    string c = string(5);
    var d = var("hello");

### Boxing and Unboxing

`var` variables are not like the other primitive types. Think about a var
as a container for an object. Here is an example that shows how vars work:

    var a = 1.45;   // a is a Float PMC with value 1.45
    var b = 5;      // b is an Integer PMC with value 5
    b = a;          // b is now a reference to the same Float PMC as a

Notice that when we assign `var` objects, we update the value in the
container, we don't change the value of the PMC that is already in the
container. Here's a version of the above code that keeps the same PMCs in
each container:

    var a = 1.45;   // a is a Float PMC with value 1.45
    var b = 5;      // b is an Integer PMC with value 5
    float f = a;    // unbox a into a float primitive
    b = f;          // calls vtable set_number_native, updating b to "1"

When working with vars, it's important to keep in mind that each operation on
the var maps to a different vtable, which changes depending on the types of
the operands. The exception is the `=` op, which might update the reference
in the container instead. Here are some examples:

    var a = 1;      // calls set_integer_native vtable on a
    var b = 3.14;   // calls set_number_native vtable on b
    var c = "var";  // valls assign_string_native vtable on c
    var d = c;      // calls the parrot 'set_p_p' op, to make d the same as c

Here are some other examples of operators on vars and the vtables they call.
for these examples, `vx` are vars, `sx` are strings, `ix` are integers, and
`fx` are floats.

    v1 = v2 + v3;   // ???
    v1 += v2;       // VTABLE_i_add(v1, v2)
    v1 = i1 + i2;   // v1 = var(i1 + i2)
    v1 = f1 + f2;   // v1 = var(v1, f1 + f2)
    v1

### Arrays

We've already covered a few of the most basic PMC types: Integer, String, and
Float. These types are the boxed forms of the three primitive types. There are
two other types that we want to look at in detail: Hash and ResizablePMCArray.

Arrays are long sequences of like objects which are identified by their
position in the array, starting with position 0.

We can create ResizablePMCArrays with bracket syntax:

    var array = [1, 2, 3, 4];

Each element in the array is separated by a comma. Size this is a PMC array,
the elements in each spot can be any type of var that we want to use,
including nested arrays:

    var array = [
        1,
        new Foo(),
        [1, 3, 4],
        "Hello"
    ];

In these initializers, primitive types like integers, floats, and strings are
automatically boxed to the storage type of the array. Notice the phrase
"storage type of the array". This is included because Parrot supports multiple
array types, of which ResizablePMCArray is just the most common. Also,
ResizablePMCArray is the type that is created with the bracket syntax. We can
also use a different type of array if we create it explicitly.

    var int_array = new 'ResizableIntegerArray'
    int_array[0] = 1;
    int_array[1] = "43";

We will talk about other types of built-in PMCs and the `new` keyword a little
bit later.

### Hashes

Hashes are key/value pairs that associate a string key to each item in the
hash.

## Expressions

Expressions are things like function calls, method calls, object allocations,
and mathematical expressions. Here are some examples:

    new Foo();
    3 + 4 * 5 - 6;
    x.Bar();
    Baz();

Basically, an expression is something which does, or might, produce a value.
We can turn expressions into statements by doing something with that value,
such as ignoring it (in the case of a function call which does not return a
value) or storing it into a variable.

    var foo = new Foo();
    int a = 3 + 4 * 5 - 6;
    var y = x.Bar();
    Baz();

## Branches

### If and Else

We can use `if`/`else` expressions to branch program flow, along with a series
of conditional operators:

    if (a == 5) {
        ...
    } else {
        ...
    }

These constructs operate exactly like their counterparts in JavaScript or C++.
The difference may lie in how the boolean value of the argument to `if` is
evaluated. Here are some examples:

1. For integers and floating point numbers, the value is true if it is
   non-zero. It is false if it is zero.
2. For strings, the string is true if it is not null or empty. It is false
   otherwise.
3. For PMC variables, the get_bool VTABLE is called to determine truth value
   on a per-type basis. Most built-in types act how you expect (Integer PMC
   follows the same truth values as the integer type primitive, same with the
   String PMC and the string primitive).

### Switch Statements

## Loops

### Classic Loops

One of the most basic loops is the three-argument `for` loop. This should be
familiar to any programmer with a C or C++ background, or a background in
languages descended from C and C++:

    for (int i = 0; i < something; i++) {
        ...
    }

This for loop is basically a compact way to write this same while loop:

    int i = 0;
    while(i < something) {
        ...
        i++
    }

There is also a do/while loop:

    do {
        ...
    } while(condition);

### Working With Loops

Use the `break` keyword to break out of a loop. Use the `continue` keyword to
immediately jump back to the top of the loop.

### Iterator `for` Loop

Parrot supports iterators internally, and any iterable type can be used with
a modified `for` loop:

    for (var item in array) {
        ...
    }

    for (string key in hash) {
        var item = hash[key];
        ...
    }

Notice that the exact behavior of the type you are iterating is determined by
that type and the get_iter VTABLE. For arrays, the iterator returns each item
in the array, typically in the order that the items are stored in the array.
For hashes, the iterator returns the string keys in pseudorandom order. Notice
that custom types or subclasses of arrays and hashes might override get_iter
and return a custom iterator with custom behavior. Don't rely on any
particular ordering, especially for iterating hashes, unless you provide a
custom iterator type to enforce ordering. We'll talk about that later.

## Builtins

A major goal for Winxed is to provide a low-level systems programming language
for Parrot to replace the current low-level coding options such as PIR. PIR
is an assembly-level language which a number of design flaws which make it
unsuitable for use by humans trying to write code, and which make it likely
to be changed dramatically or even removed entirely from Parrot in the course
of development.

Winxed provides a syntax for accessing PIR ops directly. However this is
considered bad practice to use, because PIR use in general is frowned upon.
Instead, Winxed provides a number of builtin functions as thin wrappers around
Parrot ops. This adds a layer of abstraction in case the form or function of
individual ops in Parrot changes dramatically over time.

Here are some of the most useful builtin functions which Winxed currently
provides:

* sprintf
* say
* cry
* print
* die
* exit
* time
* floattime
* spawnw
* getstdin
* getstdout
* getstderr
* open
* Error
* elements
* length
* bytelength
* substr
* replace
* indexof
* join
* split
* push
* get_class
* typeof
* getattribute
* find_method
* clone
* compreg
* load_language
* load_bytecode

# Creating Objects

## init_pmc VTABLEs

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

## Constructors

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

## Creating Objects Review

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


## Classes and Builtins

# Namespaces and Classes

We looked at namespaces briefly when talking about objects and constructors.
Now we're going to take a closer look at namespaces and some of the issues
that they bring.

## Root Namespace

## Creating Namespaces

Namespaces are defined with the `namespace` keyword:

    namespace Foo {
    }

There is no easy syntax for creating nested namespaces. You need to define
each explicitly:

    namespace Foo {
        namespace Bar {
            namespace Baz {
            }
        }
    }

Functions can be defined in a namespace. Here is an example:

    namespace Foo {
        function Hello() { say("hello world from Foo!"); }

        namespace Bar {
            function Hello() { say("hello world from Bar!"); }

            namespace Baz {
                function Hello() { say("hello world from Baz!"); }
            }
        }
    }

## Using Functions From Namespaces

Functions can be found and used in namespaces with the `using` keyword.
Following the example code above, we can access each of those functions in
the different namespaces with `using`:

    using Foo.Hello;
    Hello();

    using Foo.Bar.Hello;
    Hello();

    using Foo.Bar.Baz.Hello;
    Hello();

The `using` keyword here looks up the method specified and stores its value
into a variable with the same name. We can assign the reference, or do other
things with it:

    using Foo.Hello;
    var func = Hello;
    func();

If we want the lookup to be static and fixed at compile time, we can use the
`static` keyword:

    using static Foo.Hello;
    Hello();

With `static` the Winxed compiler will throw an error if it cannot resolve the
function at runtime. Also, the function will be made into a static constant
reference, so it cannot be assigned to a variable.

## Namespace Object References

## Creating Classes

Classes, as we've seen previously, are created with the `class` keyword.

    class Foo {
    }

Classes can be nested in Namespaces and even other Classes:

    namespace Foo {
        class Bar {
            class Baz {
            }
        }
    }

## Attributes

The var keyword is used to add attributes to a class:

    class Foo {
        var a;
        var b;
    }

In a Class method, attributes are accessed using the `self.` keyword object.

    class Foo {
        var a;
        var b;

        function Method() {
            self.a = "a";
            self.b = "b";
        }
    }

Due to limitations in Parrot, attributes are always `var` and cannot be one
of the primitive types like `int`, `float`, or `string`.

## Inheritance

Classes can inherit from one another:

    class Foo {
        function Foo_Method() { ... }
    }

    class Bar : Foo {
        function Bar_Method() { ... }
    }

    function Do_Stuff() {
        var b = new Bar;
        b.Foo_Method();
        b.Bar_Method();
    }

In the case of inheritance, the child class gets all the same methods and
attributes as the parent class, allowing for overrides in the child class. One
thing which is not automatically handled is constructor chaining.

    class Foo {
        function Foo() { ... }
    }

    class Bar : Foo {
        function Bar() {
            self.Foo();
        }
    }

    function Do_Stuff() {
        var b = new Bar();
    }

Constructors for parent classes are not automatically invoked. You must invoke
them explicitly. This can be a problem when the parent and child classes have
the same short name.

    namespace Parent {
        class MyClass {
            function MyClass() { ... }
        }
    }

    namespace Child {
        class MyClass : Parent.MyClass {
            function MyClass() {
                // Parent.MyClass.MyClass is hidden!
            }
        }
    }

    function Do_Stuff() {
        var b = new Child.MyClass();
    }

We can get around this limitation with a few tricks: `[nsentry]` and the
indirect method invoke operator. We'll talk about this in a little bit.

## Class Object References

We can get a reference to a Class object with the `class keyword`:

    var myclass = class Parent.MyClass;

## Methods and nsentry

In Parrot Classes are always associated with a namespace of the same name. So
the declaration of a new class automatically creates a namespace of the same
name, even if you can't see it:

    class Foo {
    }

This silently creates a namespace Foo too. Methods, by default, are not
stored in the namespace and we cannot search there for them. However, we can
explicitly store the method in the namespace with the `[nsentry]` flag:

    class Foo {
        function MyFunction[nsentry]() {
        }
    }

Now, the function is stored in the associated namespace and we can get a
reference to it with the `using` keyword:

    using Foo.MyFunction;
    MyFunction();

This invocation will probably fail with an argument mismatch exception because
the method is expecting an invocant but when we invoke the method like this we
aren't passing an invocant. We can specify an invocant with the `.*` operator:

    using Foo.MyFunction;
    var foo = new Foo;
    foo.*MyFunction();

We can use these two things together to allow us to call a shadowed method in
a parent class, like in the example above:

    namespace Parent {
        class MyClass {
            function MyClass[nsentry]() { ... }
        }
    }

    namespace Child {
        class MyClass : Parent.MyClass {
            function MyClass() {
                using Parent.MyClass.MyClass;
                var func = MyClass;
                self.*func();
            }
        }
    }

    function Do_Stuff() {
        var b = new Child.MyClass();
    }

One other thing we can try to do is look up the method in the parent class
object with the `class` keyword. Classes are objects, and they have methods
that we can use for things like finding methods:

    namespace Parent {
        class MyClass {
            function MyClass() { ... }
        }
    }

    namespace Child {
        class MyClass : Parent.MyClass {
            function MyClass() {
                var parent_class = class Parent.MyClass;
                var method = parent_class.find_method("MyClass");
                self.*method();
            }
        }
    }

    function Do_Stuff() {
        var b = new Child.MyClass();
    }


Either mechanism should produce the same result.

# Functions and Arguments

Functions are the most basic building blocks of a structured program. We've
already seen a few functions used throughout previous examples, but now we're
going to take a very close look at them.

## Sub and invoke VTABLE

The Parrot built-in type Sub is used to implement functions and methods, and
is the base type for other things like Coroutines which we will introduce in
a little bit.

Subs and subroutine-like behavior is provided through the invoke vtable at the
Parrot level. Any type that provides the invoke vtable can be used like a sub
or a method.

    class Foo {
        function invoke[vtable](var args, ...) { ... }
    }

    function do_stuff() {
        var f = new Foo;
        f();
    }

## Writing Programs

Let's take a small diversion and talk about programs. Program execution starts
at a main function. There are two types of main functions; One named "main"
and one marked with the `[main]` flag:

    function main() { ... }
    function main(var args) { ... }
    function main[main]() { ... }
    function main[main](var args) { ... }

For the main function the arguments list is currently optional, although this
is deprecated in Parrot. Eventually the argument to main will be required.

There is a difference between a function named "main" and a function marked
as `[main]`: The function named "main" will be executed when the program is
interpreted directly by the winxed compiler. The function marked `[main]` will
be executed by Parrot when the program has been compiled to PIR or bytecode
and executed later. Here's a short example program:

    function main() { say("In Winxed Main!"); }
    function foo[main]() { say("In Parrot Main!"); }

Save this as "test.winxed" and run it from the command prompt:

    > winxed test.winxed
    In Winxed Main!

    > winxed -c -o test.pir test.winxed
    > parrot test.pir
    In Parrot Main!

These two mechanisms might be reconciled one day, but for now it's safe to
always name your main function "main" and mark it `[main]` if you want the
behavior for both types of invocation to be the same.

Another point worth making is that if you do not mark any functions as
`[main]`, Parrot will automatically select the main function as the first
function in the file. Since winxed might be outputting functions into the PIR
file in a different order than they are defined in the Winxed file, this is
not a good thing to rely on. This behavior is also deprecated at the Parrot
level. Eventually Parrot will throw an error if you attempt to execute a PIR
or PBC file without an explicit `[main]` function.

## Argument Passing

### Basic Arguments and Parameters

We've already seen some basic arguments in examples. The arguments that you
are probably most familiar with are called "positional" arguments because they
are passed by position. There are also named arguments which are passed by
name.

Arguments are passed by position and the numbers are checked for mismatch.
Parrot will throw an exception if the number of arguments passed does not
satisfy the parameters expected. Notice the word "satisfy", instead of the
word "match". There are mechanisms in Parrot that allow the number of passed
arguments not to exactly match the number of expected parameters. We'll talk
about some of those in a little bit.

Arguments automatically coerce between primitive types. If you pass an `int`
argument and the function expects a `string` parameter, the value will be
automatically converted. This is the same for combinations of the primitive
types.

### Named Parameters

Arguments can be passed and accessed by name:

    function foo(var p, var n [named("Second")]) { }

    function main[main]() {
        foo(1, 2:[named("Second")]
    }

### Slurpy and Optional Parameters

Paramters can be marked as optional, which means they do not need to be passed
to the function at all. There are two types: optional positional parameters
fill in for positional arguments and must come at the end of all positionals.
Optional named parameters fill in for named arguments and must come at the end
of all named parameters. Each optional parameter may also include an
`[opt_flag]`, which is an int set to 1 if the value was passed and 0
otherwise.

    function foo(var a [optional], int has_a [opt_flag])
    {
        if (!has_a)
            a = <some default value>;
    }

    function bar(var a [named,optional], int has_a)
    {
        if (!has_a)
            a = <some default value>;
    }

    function main[main]() {
        foo();                  // has_a = 0
        foo(1);                 // has_a = 1
        bar();                  // has_a = 0
        bar(2:[named("a")]);    // has_a = 1
    }

Slurpy parameters create an array (for positionals) or a hash (for named)
to collect extra paramters. Slurpy parameters must appear at the end of the
argument list only.

    function foo(var p [slurpy], var n [named,slurpy]) {
        // p is an array of all positionals
        // n is a hash of all named arguments
    }

Parameters must be declared in this order:

1. All normal positional parameters
2. All optional positional parameters (and associated opt_flag )
3. A single, optional, slurpy array
4. All normal named parameters
5. All optional named parameters
6. A single, optional, slurpy hash

Parrot will throw all sorts of exceptions and create problems if you define
arguments in other orders.

When combining optional and slurpy parameters, it's important to notice that
all optional parameters will be filled with arguments before any are inserted
into the slurpy array. For named arguments, the slurpy hash contains any
named arguments which are not explicitly accepted by a different argument.
There may be items in a slurpy hash even if all the `[optional,named]`
parameters have not been filled yet.

### Flat Arguments

Arrays and Hashes can be flattened when passed as arguments. An array can be
flattened into a number of different individual positional arguments, and
hashes can be flattened into a number of different named arguments. Here are
some examples:

    function MyFunction(int a, int b, var c [slurpy]) { }

    function main[main]() {
        var args = [1, 2, 3, 4, 5];
        MyFunction(args:[flat]);
    }

In this example, the parameter `a` will have the value 1, `b` will be 2, and
the variable `c` will be the array `[3, 4, 5]`.

    function MyFunction(int a [named], int b [named],
            int c [named,optional], int has_c [opt_flag],
            var d [named,slurpy]) { ... {

    function main[main]) {
        var args = {"a" : 1, "b" : 2, "c" : 3, "d" : 4, "e" : 5};
        MyFunction(args:[flat,named]);
    }

In this example, `a` contains 1, `b` is 2, `c` is 3, `has_c` is 1, and `d` is
the hash `{"d" : 4, "e" : 5}`.

Here is a simple function to remove a single item from a hash by name:

    function delete_hash_entry(var x [named("Foo"),optional], var h [named,slurpy]) {
        return h;
    }

This isn't the most efficient way to do it, nor is it easily extendible, but
this should demonstrate some of the uses of the functionality.

## Returns



### Basic Returns

### No Return Values

### Multi Returns

Parrot uses a control mechanism called Continuation-Passing Style (CPS). In
a CPS system function calls and returns are the same: Everything is a call.
This means that function returns use the same internal mechanisms as function
calls do, and function returns can pass arguments back to the caller in the
same way as the caller passes arguments back to the function.

    :(a, b, c) = myfunction(1, 2, 3);

## Coroutines and yield

Coroutines are like functions which do not exit, but maintain state and can
continue execution again at a later point. Coroutines are differentiated by
using the `yield` keyword. A `yield` is like a return, it passes results back
to the caller. The next time the coroutine is called, execution continues from
the point of the yield. Coroutines do not reset until they return. After a
return, the Coroutine starts from the top again like normal.

    function MyCoroutine() {
        yield 1;
        yield 2;
        yield 3;
        return 4;
    }

    function main[main]() {
        for (int i = 0; i < 8; i++)
            print(MyCoroutine());
        }
    }

This prints the line "12341234" as expected. Coroutines can also be used for
implementing global data values or singletons:

    function MyValue() {
        var data = new Foo();
        while(1)
            yield data;
    }

As an example, here is how the Singleton pattern might be implemented in
Winxed:

    class MySingleton {
        function Instance[nsentry]() {
            var value = new MySingleton;
            while(1)
                yield value;
        }
    }

    function main[main]() {
        using MySingleton.Instance;
        var s = Instance();
    }

## Closures

# Using Objects

## Creating Objects

## Examining Objects

### Object Types and instanceof

### Object Roles and Capabilities

### Null and Definedness

# Closures and Scope

## Creating Closures

## Lexicals and Lexicalization

# Descending to PIR

## Using PIR Ops

# VTABLEs and Low-Level Features

## Defining and Using VTABLEs

## Gotchas and Caveats

