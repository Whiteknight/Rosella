INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/decorate.pbc");
}

Rosella::Test::test(Decorate::Factory::Test);

class Decorate::Factory::Test {
}
