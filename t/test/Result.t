INIT {
    pir::load_bytecode("rosella/test.pbc");
    # I would rather not use MockObject to test Test, since the former
    # depends on the latter. However, there is no other good way to test
    # Result
    pir::load_bytecode("rosella/mockobject.pbc");
}

Rosella::Test::test(Test::Result::Test);

class MyFakeTest is Rosella::Test::Testcase {
    method test_one() {}
}

class Test::Result::Test is Rosella::Test::Testcase {
    sub get_listener_controller() {
        my $factory := Rosella::build(Rosella::MockObject::Factory);
        return $factory.get_mock_controller(Rosella::Test::Listener);
    }

    method test_BUILD() {
        my $result := Rosella::build(Rosella::Test::Result, []);
        Assert::not_null($result);
        Assert::equal($result.was_successful(), 1);
    }

    method test_plan_tests() {
        my $c := get_listener_controller();
        $c.expect().once().method("plan_tests").with_args(3);
        my $m := $c.mock();
        my $result := Rosella::build(Rosella::Test::Result, [$m]);
        $result.plan_tests(3);
        $c.verify();
    }

    method test_start_test() {
        my $c := get_listener_controller();
        my $faketest := MyFakeTest.new();
        $c.expect().once().method("start_test").with_any_args();
        my $m := $c.mock();
        my $result := Rosella::build(Rosella::Test::Result, [$m]);
        $result.start_test($faketest);
        $c.verify();
    }

    method test_end_test() {
        my $c := get_listener_controller();
        my $faketest := MyFakeTest.new();
        $c.expect().once().method("end_test").with_any_args();
        my $m := $c.mock();
        my $result := Rosella::build(Rosella::Test::Result, [$m]);
        $result.end_test($faketest);
        $c.verify();
    }

    method test_add_error() {
        my $c := get_listener_controller();
        my $faketest := MyFakeTest.new();
        $c.expect().once().method("add_error").with_any_args();
        my $m := $c.mock();
        my $result := Rosella::build(Rosella::Test::Result, [$m]);
        Assert::equal($result.was_successful, 1);
        $result.add_error($faketest, "oops");
        $c.verify();
        Assert::equal($result.was_successful, 0);
    }

    method test_add_failure() {
        my $c := get_listener_controller();
        my $faketest := MyFakeTest.new();
        $c.expect().once().method("add_failure").with_any_args();
        my $m := $c.mock();
        my $result := Rosella::build(Rosella::Test::Result, [$m]);
        Assert::equal($result.was_successful, 1);
        $result.add_failure($faketest, "oops");
        $c.verify();
        Assert::equal($result.was_successful, 0);
    }
}
