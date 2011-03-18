INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(ActionArgInstanceTest);

class ActionArgInstanceTest {
    method test_BUILD() {
        my $arg := Rosella::build(Rosella::Action::Argument::Instance, 1);
    }
}
