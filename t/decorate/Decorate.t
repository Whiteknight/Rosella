INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/decorate.pbc");
}

Rosella::Test::test(Decorate::Test);

class Decorate::Test {
    method test_add_methods() {
        $!status.unimplemented("Write tests for this");
    }

    method test_add_methods_override() {
        $!status.unimplemented("Write tests for this");
    }

    method test_add_attributes() {
        $!status.unimplemented("Write tests for this");
    }

    method test_add_attributes_override() {
        $!status.unimplemented("Write tests for this");
    }
}
