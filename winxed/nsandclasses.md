---
layout: winxed
title: Namespaces and Classes
---

We looked at namespaces briefly when talking about objects and constructors.
Now we're going to take a closer look at namespaces and some of the issues
that they bring.

## Root Namespace

## Creating Namespaces

Namespaces are defined with the `namespace` keyword:

    namespace Foo {
    }

There is an easy syntax for nested namespaces:

    namespace Foo.Bar.Baz {
        ...
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

Same as:

    namespace Foo {
        function Hello() { say("hello world from Foo!"); }
    }
    namespace Foo.Bar {
        function Hello() { say("hello world from Bar!"); }
    }
    namespace Foo.Bar.Baz {
        function Hello() { say("hello world from Baz!"); }
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

The `using` and `using static` directives perform a lookup at runtime and store
a reference to the subroutine into a variable with the same name. This is useful
if you need to pass a Sub reference as data to another function.

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

Which is the same as:

    class Foo.Bar {
        class Baz {
        }
    }

Which is still the same as:

    class Foo.Bar {
    }
    class Foo.Bar.Baz {
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
of the primitive types like `int`, `float`, or `string`. This limitation may be
removed in the future.

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
explicitly store the method in the namespace with the `[nsentry]` modifier:

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

    class Parent.MyClass {
        function MyClass[nsentry]() { ... }
    }

    class Child.MyClass : Parent.MyClass {
        function MyClass() {
            using Parent.MyClass.MyClass;
            var func = MyClass;
            self.*func();
        }
    }

    function Do_Stuff() {
        var myclass = new
        var b = new Child.MyClass();
    }

One other thing we can try to do is look up the method in the parent class
object with the `class` keyword. Classes are objects, and they have methods
that we can use for things like finding methods:

    class Parent.MyClass {
        function MyClass() { ... }
    }

    class Child.MyClass : Parent.MyClass {
        function MyClass() {
            var parent_class = class Parent.MyClass;
            var method = parent_class.find_method("MyClass");
            self.*method();
        }
    }

    function Do_Stuff() {
        var b = new Child.MyClass();
    }


Either mechanism should produce the same result.
