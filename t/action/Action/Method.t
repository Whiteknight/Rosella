INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/action.pbc");
}

Rosella::Test::test(ActionMethodTest);

class ActionMethodTest is Rosella::Test::Testcase {
    method test_BUILD() {
        my $action := Rosella::build(Rosella::Action::Method, "test", []);
        Assert::instance_of($action, Rosella::Action::Method, "Is not a Method");
    }
}
