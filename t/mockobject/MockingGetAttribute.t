INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(Mocking::GetAttribute::Test);
class Mocking::GetAttribute::Test is Rosella::Test::Testcase {
    method test_one_get_return_pass() {
        Assert::expect_pass(sub() {
            my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
            my $c := $f.get_mock_controller();
            $c.expect().once().get_attribute("test").will_return(2);
            my $m := $c.mock();
            my $result := pir::getattribute__PPS($m, "test");
            Assert::equal($result, 2);
            $c.verify();
        });
    }
}
