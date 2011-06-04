---
layout: rosella
title: Functions and Arguments
---

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
and one marked with the `[main]` modifier:

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

    function myfunction() {
        return 1, 2, 3;
    }

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

Closures are anonymous functions that are created and contain state
information from the function that created them. A closure "closes" over the
current lexical scope where it is created, keeping references to the variables
used in the parent function. Creating a closure forces the parent context to
stay alive so that the variables in that context can be referenced by the
closure. Only `var` variables can be lexically scoped and therefore made
available in closures.

    function foo(int a) {
        var var_a = a;      // promote a to var, so we can close it
        return function() {
            return var_a;
        };
    }

    function main[main]() {
        var f5 = foo(5);
        var f7 = foo(7);
        say(f5());      // "5"
        say(f7());      // "7"
        say(f5());      // "5"
        say(f7());      // "7"
    }

The `function` keyword is used to create normal subroutines (in namespaces),
methods (in classes) and closures (in functions). It is important to remember
that all `function`s are objects and can be passed around like objects.
