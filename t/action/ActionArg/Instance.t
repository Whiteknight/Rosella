INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Testcase::test(ActionArgInstanceTest);

class ActionArgInstanceTest is Rosella::Testcase {
    method test_BUILD() {
        my $arg := Rosella::build(Rosella::ActionArg::Instance, 1);
    }
}