INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/tap_harness.pbc");
}

Rosella::Test::test(Harness::Test);

class Harness::Test {
}
