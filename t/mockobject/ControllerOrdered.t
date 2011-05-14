INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(MockObject::Controller::Ordered::Test);
class MockObject::Controller::Ordered::Test {
    method test_one_method_pass() {
        my $f := Rosella::construct(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClass, :ordered(1));
        $c.expect_method("test").once.with_args(1, 2, 3);
        my $m := $c.mock();
        $m.test(1, 2, 3);
        $c.verify();
    }

    method test_two_method_pass() {
        my $f := Rosella::construct(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClass, :ordered(1));
        $c.expect_method("test").once.with_args(1, 2, 3);
        $c.expect_method("test").once.with_args(4, 5, 6);
        my $m := $c.mock();
        $m.test(1, 2, 3);
        $m.test(4, 5, 6);
        $c.verify();
    }

    method test_two_method_fail_unordered() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass, :ordered(1));
            $c.expect_method("test").once.with_args(1, 2, 3);
            $c.expect_method("test").once.with_args(4, 5, 6);
            my $m := $c.mock();
            $m.test(4, 5, 6);
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_repeat_method_pass() {
        my $f := Rosella::construct(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClass, :ordered(1));
        $c.expect_method("test_a").at_least(2).with_args(1, 2, 3);
        $c.expect_method("test_b").once.with_args(4, 5, 6);
        my $m := $c.mock();
        $m.test_a(1, 2, 3);
        $m.test_a(1, 2, 3);
        $m.test_b(4, 5, 6);
        $c.verify();
    }

    method test_repeat_method_pass_overkill() {
        my $f := Rosella::construct(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClass, :ordered(1));
        $c.expect_method("test_a").at_least(2).with_args(1, 2, 3);
        $c.expect_method("test_b").once.with_args(4, 5, 6);
        my $m := $c.mock();
        $m.test_a(1, 2, 3);
        $m.test_a(1, 2, 3);
        $m.test_a(1, 2, 3);
        $m.test_a(1, 2, 3);
        $m.test_a(1, 2, 3);
        $m.test_a(1, 2, 3);
        $m.test_b(4, 5, 6);
        $c.verify();
    }

    method test_repeat_method_fail_unordered() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass, :ordered(1));
            $c.expect_method("test").at_least(2).with_args(1, 2, 3);
            $c.expect_method("test").once.with_args(4, 5, 6);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $m.test(4, 5, 6);
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_repeat_method_fail_extra() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass, :ordered(1));
            $c.expect_method("test").at_least(2).with_args(1, 2, 3);
            $c.expect_method("test").once.with_args(4, 5, 6);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $m.test(1, 2, 3);
            $m.test(4, 5, 6);
            $m.test(1, 2, 3);
            $c.verify();
        });
    }
}
