INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(MockObject::FactoryTest);
class MockObject::FactoryTest is Rosella::Test::Testcase {
    method test_build() {
        my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
        Assert::not_null($f);
    }

    method test_get_mock_controller() {
        my $f := Rosella::build(Rosella::MockObject::Factory, MyClass);
        my $c := $f.get_mock_controller();
        Assert::not_null($c);
    }
}




