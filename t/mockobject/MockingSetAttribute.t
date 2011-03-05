INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(Mocking::SetAttribute::Test);
class Mocking::SetAttribute::Test is Rosella::Test::Testcase {
    method test_one_set_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().set_attribute("test").with_args(2);
            my $m := $c.mock();
            pir::setattribute__vPSP($m, "test", 2);
            $c.verify();
        });
    }
}
