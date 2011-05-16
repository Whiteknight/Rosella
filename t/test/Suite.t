INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

Rosella::Test::test(Test::Suite::Test);

class MyFakeTest {
    method test_one() {}
    method test_two() {}
    method test_three() {}
}

class MyFakeSubTest is MyFakeTest {
    method test_one() {}
    method test_four() {}
}

class MyTestResult { }

class Test::Suite::Test {
    method test_BUILD() {
        my $suite := Rosella::construct(Rosella::Test::Suite, [], "suite");
        $!assert.not_null($suite);
    }

    method test_default_result() {
        my $suite := Rosella::construct(Rosella::Test::Suite, [], "suite");
        my $result := $suite.default_result();
        $!assert.equal(~(pir::typeof__SP($result)), "Rosella;Test;Result");
    }

    method test_run() {
        $!status.unimplemented("Find a way to test Suite.run()");
    }

    method test_run_test() {
        my $suite := Rosella::construct(Rosella::Test::Suite, [], "suite");
        my $f := Rosella::construct(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyTestResult);
        $c.expect_method("start_test").once.with_any_args;
        $c.expect_method("end_test").once.with_any_args;
        my $result := $c.mock;
        $suite.run_test("my_test_function", my_test_function, $result);
    }
}
