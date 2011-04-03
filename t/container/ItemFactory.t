INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/container.pbc");
}

Rosella::Test::test(Container::ItemFactory::Test);

class Container::ItemFactory::Test {
    method test_create() {
        $!status.unimplemented("test create with no initializers");
    }

    method test_create_initializers() {
        $!status.unimplemented("test create with initializers");
    }

    method test_create_typed() {
        $!status.unimplemented("test create_typed with no initializers");
    }

    method test_create_typed_initializers() {
        $!status.unimplemented("test create with initializers");
    }
}
