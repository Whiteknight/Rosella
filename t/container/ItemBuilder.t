INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/container.pbc");
}

ItemBuilderTest.suite.run();

class ItemBuilderTest is Rosella::Testcase {
}
