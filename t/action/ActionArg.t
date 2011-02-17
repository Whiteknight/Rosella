INIT {
    pir::load_bytecode("parrot_test_xunit.pbc");
    pir::load_bytecode("parrot_container_action.pbc");
}

ActionArgTest.suite.run();

class ActionArgTest is ParrotTest::Testcase {
    method test_BUILD() {
        my $arg := ParrotContainer::build(ParrotContainer::ActionArg);
    }
}
