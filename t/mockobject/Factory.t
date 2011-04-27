INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

class MyClassA { }
class MyClassB { }
class MyClassC { }
class MyClassD { }

Rosella::Test::test(MockObject::FactoryTest);
class MockObject::FactoryTest {
    method test_build() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        $!assert.not_null($f);
    }

    method test_get_mock_controller() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClassA);
        $!assert.not_null($c);
        $!assert.instance_of($c, Rosella::MockObject::Controller);
        $!assert.not_instance_of($c, Rosella::MockObject::Controller::Ordered);
    }

    method test_get_mock_controller_unordered() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClassB, :ordered(0));
        $!assert.not_null($c);
        $!assert.instance_of($c, Rosella::MockObject::Controller);
        $!assert.not_instance_of($c, Rosella::MockObject::Controller::Ordered);
    }

    method test_get_mock_controller_ordered() {
        my $f := Rosella::build(Rosella::MockObject::Factory);
        my $c := $f.create_typed(MyClassC, :ordered(1));
        $!assert.not_null($c);
        $!assert.instance_of($c, Rosella::MockObject::Controller);
        $!assert.instance_of($c, Rosella::MockObject::Controller::Ordered);
    }
}




