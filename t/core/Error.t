INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(ErrorTest);

class ErrorTest {
    method test_fail() {
        $!status.unimplemented("Test this");
    }
}
