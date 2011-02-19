INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/prototype.pbc");
}

Rosella::Testcase::test(PrototypeManagerTest);

class PrototypeManagerTest is Rosella::Testcase {
    method test_BUILD() {
        my $pm := Rosella::build(Rosella::Prototype::Manager);
    }
}
