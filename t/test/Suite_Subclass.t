INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

Rosella::Test::test(Test::Suite_Subclass::Test);

class MyTestSuite is Rosella::Test::Suite {
    method execute_test($test, $method) {
        pir::say("Executing test '$method'");
    }
}

class MyTestObject { }
class MyTestResult { }

sub my_test_function(*@args) { }

class Test::Suite_Subclass::Test {
    method test_run_test_subclass() {
        my $suite := MyTestSuite.new();

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

        $!assert.output_is({
            $suite.run_test("my_test_function", $test, $result);
        }, "Executing test 'my_test_function'\n");

        $cresult.verify();
        $ctest.verify();
    }
}
