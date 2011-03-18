INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/prototype.pbc");
}

Rosella::Test::test(PrototypeManagerTest);

class PrototypeManagerTest {
    method test_BUILD() {
        my $pm := Rosella::build(Rosella::Prototype::Manager);
    }
}
