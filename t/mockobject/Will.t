INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "mockobject");
}

class MyClass { }

Rosella::Test::test(MockObject::Expectation::Will::Test);
class MockObject::Expectation::Will::Test {
    sub get_controller() {
        my $f := Rosella::construct(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClass);
    }

    method test_will_return() {
        my $c := get_controller();
        $c.expect_method("test").once.will_return("foo");
        my $m := $c.mock;
        my $result := $m.test();
        $!assert.equal($result, "foo");
        $c.verify;
    }

    method test_will_throw() {
        $!assert.throws(sub() {
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
        $!assert.equal($result, 4);
        $!assert.equal($value, 12);
        $c.verify;
    }
}
