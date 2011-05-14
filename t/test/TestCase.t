INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::TestCase::Test);

class Test::TestCase::Test {
    method test_make() {
        # We need a TestFactory to make a TestCase
        my %options := {};
        %options{"testcase_type"} := Rosella::Test::TestCase;
        my $factory := Rosella::construct(Rosella::Test::TestFactory, %options);
        my $testcase := $factory.create("Bar", "Baz");
    }

    method test_attrs() {
        # We need a TestFactory to make a TestCase
        my %options := {};
        %options{"testcase_type"} := Rosella::Test::TestCase;
        %options{"context"} := "Foo";
        my $factory := Rosella::construct(Rosella::Test::TestFactory, %options);
        my $testcase := $factory.create("Bar", "Baz");
        $!assert.equal(pir::getattribute__PPS($testcase, 'method'), "Baz");
        $!assert.equal(pir::getattribute__PPS($testcase, '$!method'), "Baz");
        $!assert.equal(pir::getattribute__PPS($testcase, 'context'), "Foo");
        $!assert.equal(pir::getattribute__PPS($testcase, '$!context'), "Foo");
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
