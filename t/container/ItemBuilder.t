INIT {
    pir::load_bytecode("parrot_test_xunit.pbc");
    pir::load_bytecode("parrot_container.pbc");
}

ItemBuilderTest.suite.run();

class ItemBuilderTest is ParrotTest::Testcase {
}
