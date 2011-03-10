INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(MockObject::Expectation::Test);
class MockObject::Expectation::Test is Rosella::Test::Testcase {
    sub get_controller() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        return $f.get_mock_controller(MyClass,);
    }

    method test_no_expectations() {
        my $c := get_controller();
        $c.verify;
    }

    method test_null_expectation() {
        Assert::expect_fail(sub() {
            my $c := get_controller();
            $c.expect;
            $c.verify;
        });
    }

    method test_default_method() {
        my $c := get_controller();
        $c.expect.method("test");
        my $m := $c.mock();
        $m.test();
        $c.verify();
    }

    method test_default_get() {
        my $c := get_controller();
        $c.expect.get("test");
        my $m := $c.mock();
        my $dummy := pir::getattribute__PPS($m, "test");
        $c.verify();
    }

    method test_default_set() {
        my $c := get_controller();
        $c.expect.set("test");
        my $m := $c.mock();
        pir::setattribute__vPSP($m, "test", "foo");
        $c.verify();
    }
}
