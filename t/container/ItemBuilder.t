INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/container.pbc");
}

Rosella::Test::test(ItemBuilderTest);

class ItemBuilderTest is Rosella::Test::Testcase {
}
