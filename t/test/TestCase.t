INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::TestCase::Test);

class Test::TestCase::Test {
    method test_make() {
        # We need a TestFactory to make a TestCase
        my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
        my $testcase := $factory.create("Bar", "Baz");
    }

    method test_attrs() {
        # We need a TestFactory to make a TestCase
        my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
        my $testcase := $factory.create("Bar", "Baz");
        Assert::equal(pir::getattribute__PPS($testcase, 'method'), "Baz");
        Assert::equal(pir::getattribute__PPS($testcase, '$!method'), "Baz");
        Assert::equal(pir::getattribute__PPS($testcase, 'context'), "Foo");
        Assert::equal(pir::getattribute__PPS($testcase, '$!context'), "Foo");
    }

    method cant_set_method() {
        Assert::throws({
            my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, "method", "Fie");
        });
        Assert::throws({
            my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, '$!method', "Fie");
        });
        Assert::throws({
            my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, 'test_method', "Fie");
        });
    }

    method cant_set_context() {
        Assert::throws({
            my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, "context", "Fie");
        });
        Assert::throws({
            my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, '$!context', "Fie");
        });
        Assert::throws({
            my $factory := Rosella::build(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, 'test_context', "Fie");
        });
    }
}
