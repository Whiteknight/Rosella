INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "mockobject");
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
        my $suite := Rosella::construct(Rosella::Test::Suite, [], "suitefactory", "testfactory");
        $!assert.not_null($suite);
    }

    method test_run() {
        $!status.unimplemented("Find a way to test Suite.run()");
    }

    method test_run_test() {
        $!status.unimplemented("Test has weirdness");
        my $suite := Rosella::construct(Rosella::Test::Suite, [], "suitefactory", "testfactory");

        my $fresult := Rosella::construct(Rosella::MockObject::Factory);
        my $cresult := $fresult.create_typed(MyTestResult);
        $cresult.expect_method("start_test").once.with_any_args;
        $cresult.expect_method("end_test").once.with_any_args;
        my $result := $cresult.mock;

        my $ftest := Rosella::construct(Rosella::MockObject::Factory);
        my $ctest := $ftest.create_typed(MyTestResult);
        $ctest.expect_get("method").once.will_return(my_test_function);
        $ctest.expect_get("status").at_least(1).will_return(1);
        my $test := $ctest.mock;

        $suite.__run_test("my_test_function", $test, $result, "context", "asserter");

        $cresult.verify();
        $ctest.verify();
    }
}
