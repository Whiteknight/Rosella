---
layout: rosella
title: Using Mocks
---

## Uses and Caveats

Mock objects are useful for isolating individual components in a complex
system for rigorous testing. Mocks can be very useful in the following
situations:

* To test dispatchers which call specific methods depending upon the values
  of input parameters.
* To test logic which uses indirect dynamic dispatch (Calling a method by
  name, especially a name which is determined at runtime).
* To test certain patterns which pass control to a separate concrete handler
  or implementation. Some specific patterns which might benefit from this kind
  of testing are: Facade, Proxy, Chain-of-Responsibility, Strategy, State,
  Abstract Factory, Bridge, Adaptor, Front Controller, Mediator and Visitor)
* To test that complex objects make proper use of defined interfaces and
  protocols

Mocks should not be used for:

* Over-specifying, or stringently specifying, the behavior of a piece of
  software which is not completely finalized.
* Testing components whose internal implementation or internal algorithms are
  expected to change.
* Specifying the exact structure of internal or hidden algorithms.

Describing a method call using mock objects takes at least 2 or 3 times as
much effort as simply writing the method call directly in normal code. If you
use a complete mock object specification for each call or each pathway in your
program you are going to have to write 2-3 times as much code up front, and
will have to spend that same amount of effort for each modification which is
made to the code.

Knowing when to use mock objects is as important as knowing when not to use
them. Mocks are powerful, but can be dangerous and counter-productive if used
improperly. In many cases refactoring code to be more admissible to normal
unit test strategies is preferred over the use of mocks.

Mocks can allow you to specify certain behaviors with a high amount of
precision. In many cases specifying less precision with your mocks can give
you the same level of assurance, but require significantly less maintenance
effort over time. For instance, not specifying a verbatim list of parameters
for a method call can prove that the method was called without mandating
exactly *how* it was called.

## Using Mocks

Here's how you use a mock in the most basic way:

1. Create the `Rosella.MockObject.Factory` object to create mocks.
2. Create the `Rosella.MockObject.Controller` object from the Factory.
3. Set up the expectations on the Controller.
4. Get the configured mock from the Controller.
5. Execute the test sequence.
6. Call the `.verify` method on the Controller, to check for any outstanding
   expectations.

## Mock Examples

For a mock object, there are several things you can specify:

1. The type of access (method, get attribute, set attribute, etc).
2. The number of times that field is accessed
3. The parameters used for the access ("with")
4. The behavior the access should perform ("will")

You can specify all or some of these things. You cannot provide conflicting
expectations in each area. For instance, you cannot write:

    $controller.expect_method("test").with_any_args().with_no_args();

That sequence will throw an exception because you've specified the "with"
behavior twice.

Expect method calls:

    # Expect the method "test" to be called.
    $controller.expect_method("test");

    # The example above is equivalent to these defaults:
    $controller.expect_method("test").once().with_any_args()

    # Expect the "test" method to be called at least 3 times
    $controller.expect_method("test").at_least(3)

    # Expect the "test" method to be called at most 5 times
    $controller.expect_method("test").at_most(5)

    # Expect the "test" method to be called with the arguments (1, 2, 3)
    $controller.expect_method("test").with_args(1, 2, 3);

    # Expect the method "test" to be called twice, with any arguments.
    # "with_any_args" is the default behavior
    $controller.expect_method("test").exactly(2).with_any_args();

## Testing with Mocks



