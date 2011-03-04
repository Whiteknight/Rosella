INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(ActionArgInstanceTest);

class ActionArgInstanceTest is Rosella::Test::Testcase {
    method test_BUILD() {
        my $arg := Rosella::build(Rosella::ActionArg::Instance, 1);
    }
}
