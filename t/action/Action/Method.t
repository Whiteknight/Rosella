INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Testcase::test(ActionMethodTest);

class ActionMethodTest is Rosella::Testcase {
    method test_BUILD() {
        my $action := Rosella::build(Rosella::Action::Method, "test", []);
        Assert::instance_of($action, Rosella::Action::Method, "Is not a Method");
    }
}
