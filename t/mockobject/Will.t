INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(MockObject::Expectation::Will::Test);
class MockObject::Expectation::Will::Test is Rosella::Test::Testcase {
    sub get_controller() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClass);
    }

    method test_will_return() {
        my $c := get_controller();
        $c.expect_method("test").once.will_return("foo");
        my $m := $c.mock;
        my $result := $m.test();
        Assert::equal($result, "foo");
        $c.verify;
    }

    method test_will_throw() {
        Assert::throws(sub() {
            my $c := get_controller();
            $c.expect_method("test").once.will_throw("oopsies");
            my $m := $c.mock;
            $m.test();
            $c.verify;
        });
    }

    method test_will_do() {
        my $c := get_controller();
        my $value := 5;
        $c.expect_method("test").once.will_do(sub() {
            $value := $value + 7;
            return 4;
        });
        my $m := $c.mock;
        my $result := $m.test();
        Assert::equal($result, 4);
        Assert::equal($value, 12);
        $c.verify;
    }
}
