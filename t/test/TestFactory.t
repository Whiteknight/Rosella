INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::TestFactory::Test);

class Test::TestFactory::Test {
    method test_BUILD() {
        my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "context");
    }

    method test_create_TestCase() {
        my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "context");
        my $testcase := $factory.create("Foo", "Bar");
        Assert::instance_of($testcase, Rosella::Test::TestCase);
    }

    method test_create_custom_subclass() {
        $!context.unimplemented("TestFactory should be able to return a subclass of TestCase");
    }

    method test_create_typed_TestCase() {
        my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "context");
        my $testcase := $factory.create_typed(Rosella::Test::TestCase, "Foo", "Bar");
        Assert::instance_of($testcase, Rosella::Test::TestCase);
    }

    method test_create_typed_custom_subclass() {
        $!context.unimplemented("TestFactory should be able to return a subclass of TestCase");
    }
}
