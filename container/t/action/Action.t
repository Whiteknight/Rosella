INIT {
    pir::load_bytecode("parrot_test_xunit.pbc");
    pir::load_bytecode("parrot_container_action.pbc");
}

ActionTest.suite.run();

class ActionTest is ParrotTest::Testcase {
    method test_BUILD() {
        my $action := ParrotContainer::build(ParrotContainer::Action, "foo", []);
        Assert::instance_of($action, ParrotContainer::Action, "Is not an Action");
    }

    method test_prepare_args_empty() {
        my $action := ParrotContainer::build(ParrotContainer::Action, "foo", []);
        my @pos := [];
        my %named := {};
        $action.prepare_args(@pos, %named);
    }
}
