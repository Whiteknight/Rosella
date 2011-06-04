---
layout: rosella
title: Syntax and Types
---

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

## Error Handling and Exceptions

### Try/Catch
