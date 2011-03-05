INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(Mocking::Methods::Test);
class Mocking::Methods::Test is Rosella::Test::Testcase {
    method test_one_method_pos_args_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_args(1, 2, 3);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_one_method_pos_args_fail_args_bad_values() {
        Assert::expect_fail(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_args(1, 2, 4);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_one_method_pos_args_fail_args_bad_arity() {
        Assert::expect_fail(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_args(1, 2, 3, 4);
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    method test_one_method_no_args_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_no_args();
            my $m := $c.mock();
            $m.test();
            $c.verify();
        });
    }

    method test_one_method_no_args_fail_with_pos_args() {
        Assert::expect_fail(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_no_args();
            my $m := $c.mock();
            $m.test(1, 2, 3);
            $c.verify();
        });
    }

    #method test_one_method_no_args_fail_with_named_args() {
    #    Assert::expect_fail(sub() {
    #        my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
    #        my $c := $f.get_mock_controller();
    #        $c.expect().once().method("test").with_no_args();
    #        my $m := $c.mock();
    #        $m.test(3:[named("whatever")]);
    #        $c.verify();
    #    });
    #}

    method test_one_method_args_return_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_args(1, 2, 3).will_return(4);
            my $m := $c.mock();
            my $r := $m.test(1, 2, 3);
            Assert::equal($r, 4);
            $c.verify();
        });
    }

    method test_one_method_args_return_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_args(1, 2, 3).will_return(4);
            my $m := $c.mock();
            my $r := $m.test(1, 2, 3);
            Assert::equal($r, 4);
            $c.verify();
        });
    }

    method test_one_method_args_will_throw() {
        Assert::throws(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().method("test").with_args(1, 2, 3).will_throw("whoops");
            my $m := $c.mock();
            my $r := $m.test(1, 2, 3);
        });
    }

    method test_none_methods_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().none().method("test");
            my $m := $c.mock();
            $c.verify();
        });
    }

    method test_none_methods_fail() {
        Assert::expect_fail(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().none().method("test");
            my $m := $c.mock();
            $m.test();
        });
    }

    method test_atleast_method_pass_equal() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().at_least(3).method("test").with_any_args();
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atleast_method_pass_greater() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().at_least(3).method("test").with_any_args();
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atleast_method_fail() {
        Assert::expect_fail(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().at_least(3).method("test").with_any_args();
            my $m := $c.mock();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atmost_method_pass_equal() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().at_most(3).method("test").with_any_args();
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }

    method test_atmost_method_pass_less() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().at_most(3).method("test").with_any_args();
            my $m := $c.mock();
            $m.test();
            $c.verify();
        });
    }

    method test_atmost_method_fail() {
        Assert::expect_fail(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().at_most(3).method("test").with_any_args();
            my $m := $c.mock();
            $m.test();
            $m.test();
            $m.test();
            $m.test();
            $c.verify();
        });
    }
}

#$c.expect().none().method("test").with_args(1, 2, 5).will_return(4);

#$c.expect().once().set_attribute("foo").with_args("bart");

#$c.expect().once().get_attribute("baz").will_throw("damnit");


#Q:PIR {
#    $P0 = find_lex "$m"
#    $P2 = getattribute $P0, "baz"
#    say $P2
#};


#pir::say($r);
