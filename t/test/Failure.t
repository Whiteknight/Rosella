INIT {
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Failure::Test);

class Test::Failure::Test {
}
