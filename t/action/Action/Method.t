INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

ActionMethodTest.suite.run();

class ActionMethodTest is Rosella::Testcase {
    method test_BUILD() {
        my $action := Rosella::build(Rosella::Action::Method, "test", []);
        Assert::instance_of($action, Rosella::Action::Method, "Is not a Method");
    }
}
