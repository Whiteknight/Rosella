INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::TestCase::Test);

class Test::TestCase::Test {
    method test_make() {
        my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase);
        my $testcase := $factory.create("Bar", "Baz");
    }

    method test_attrs() {
        # We need a TestFactory to make a TestCase
        my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase);
        my $testcase := $factory.create("Baz");
        $!assert.equal(pir::getattribute__PPS($testcase, 'method'), "Baz");
        $!assert.equal(pir::getattribute__PPS($testcase, '$!method'), "Baz");
    }

    method cant_set_method() {
        $!assert.throws({
            my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, "method", "Fie");
        });
        $!assert.throws({
            my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, '$!method', "Fie");
        });
        $!assert.throws({
            my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, 'test_method', "Fie");
        });
    }

    method cant_set_context() {
        $!assert.throws({
            my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, "context", "Fie");
        });
        $!assert.throws({
            my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, '$!context', "Fie");
        });
        $!assert.throws({
            my $factory := Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase, "Foo");
            my $testcase := $factory.create("Bar", "Baz");
            pir::setattribute__vPSP($testcase, 'test_context', "Fie");
        });
    }
}
