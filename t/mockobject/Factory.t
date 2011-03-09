INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClass { }

Rosella::Test::test(MockObject::FactoryTest);
class MockObject::FactoryTest is Rosella::Test::Testcase {
    method test_build() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        Assert::not_null($f);
    }

    method test_get_mock_controller() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        my $c := $f.get_mock_controller(MyClass);
        Assert::not_null($c);
        Assert::instance_of($c, Rosella::MockObject::Controller);
        Assert::not_instance_of($c, Rosella::MockObject::Controller::Ordered);
    }

    method test_get_mock_controller_unordered() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        my $c := $f.get_mock_controller(MyClass, :ordered(0));
        Assert::not_null($c);
        Assert::instance_of($c, Rosella::MockObject::Controller);
        Assert::not_instance_of($c, Rosella::MockObject::Controller::Ordered);
    }

    method test_get_mock_controller_ordered() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        my $c := $f.get_mock_controller(MyClass, :ordered(1));
        Assert::not_null($c);
        Assert::instance_of($c, Rosella::MockObject::Controller);
        Assert::instance_of($c, Rosella::MockObject::Controller::Ordered);
    }
}




