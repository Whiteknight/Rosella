INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/decorate.pbc");
}

Rosella::Test::test(Decorate::Builder::Test);

class Decorate::Builder::Test {
}
