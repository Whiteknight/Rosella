---
layout: rosella
title: Basic Unit Testing
---

Here's the basic framework for writing unit tests in NQP:

    INIT {
        pir::load_bytecode("rosella/test.pbc");
    }

    Rosella::Test::test(MyTestClass);

    class MyTestClass {
    }

Unit test files tend to be run individually, so there is not much concern
that test class names are going to conflict between different files. However,
it is still good practice to name your test class something similar to the
thing you are testing. For instance, if you are testing a class called
`Frobulator`, you may want to name your test class `Test::Frobulator` or
`Frobulator::Test`.


