INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/container.pbc");
}

Rosella::Testcase::test(ItemBuilderTest);

class ItemBuilderTest is Rosella::Testcase {
}
