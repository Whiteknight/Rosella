INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Builder::Test);

class Test::Builder::Test {
}
