INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

ActionArgTest.suite.run();

class ActionArgTest is Rosella::Testcase {
    method test_BUILD() {
        my $arg := Rosella::build(Rosella::ActionArg);
    }
}
