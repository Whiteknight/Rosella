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

sub my_test_function(*@args) { }

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

        my $fresult := Rosella::construct(Rosella::MockObject::Factory);
        my $cresult := $fresult.create_typed(MyTestResult);
        $cresult.expect_method("start_test").once.with_any_args;
        $cresult.expect_method("end_test").once.with_any_args;
        my $result := $cresult.mock;

        my $ftest := Rosella::construct(Rosella::MockObject::Factory);
        my $ctest := $ftest.create_typed(MyTestResult);
        $ctest.expect_get("method").once.will_return(my_test_function);
        $ctest.expect_get("status").once.will_return(1);
        my $test := $ctest.mock;

        $suite.__run_test("my_test_function", $test, $result);

        $cresult.verify();
        $ctest.verify();
    }
}
