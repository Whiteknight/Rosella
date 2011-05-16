INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(Mocking::Methods::Test);
class Mocking::Methods::Test {
    method test_one_method_pos_args_pass() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_args(1, 2, 3);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_one_method_pos_args_fail_args_bad_values() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_args(1, 2, 4);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_one_method_pos_args_fail_args_bad_arity() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_args(1, 2, 3, 4);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_one_method_no_args_pass() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_no_args;
            my $m := $c.mock();
            $m.test();
            $c.verify();
        });
    }

    method test_one_method_no_args_fail_with_pos_args() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_no_args;
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    #method test_one_method_no_args_fail_with_named_args() {
    #    $!assert.expect_fail(sub() {
    #        my $f := Rosella::construct(Rosella::MockObject::Factory, MyClass);
    #        my $c := $f.create_typed();
    #        $c.expect().once().method("test").with_no_args();
    #        my $m := $c.mock();
    #        $m.test(3:[named("whatever")]);
    #        $c.verify();
    #    });
    #}

    method test_one_method_args_return_pass() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_args(1, 2, 3).will_return(4);
            my $m := $c.mock();
            my $r := $m.test(1, 2, 3);
            $!assert.equal($r, 4);
            $c.verify();
        });
    }

    method test_one_method_args_return_pass() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_args(1, 2, 3).will_return(4);
            my $m := $c.mock();
            my $r := $m.test(1, 2, 3);
            $!assert.equal($r, 4);
            $c.verify();
        });
    }

    method test_one_method_args_will_throw() {
        $!assert.throws(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").once.with_args(1, 2, 3).will_throw("whoops");
            my $m := $c.mock();
            my $r := $m.test(1, 2, 3);
        });
    }

    method test_none_methods_pass() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").none;
            my $m := $c.mock();
            $c.verify();
        });
    }

    method test_none_methods_fail() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").none;
            my $m := $c.mock();
            $m.test();
            $c.verify();
        });
    }

    method test_atleast_method_pass_equal() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").at_least(3).with_any_args;
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atleast_method_pass_greater() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").at_least(3).with_any_args;
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atleast_method_fail() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").at_least(3).with_any_args;
            my $m := $c.mock();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atmost_method_pass_equal() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").at_most(3).with_any_args;
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atmost_method_pass_less() {
        $!assert.expect_pass(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").at_most(3).with_any_args;
            my $m := $c.mock();
            $m.test();
            $c.verify();
        });
    }

    method test_atmost_method_fail() {
        $!assert.expect_fail(sub() {
            my $f := Rosella::construct(Rosella::MockObject::Factory);
            my $c := $f.create_typed(MyClass);
            $c.expect_method("test").at_most(3).with_any_args;
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }
}
