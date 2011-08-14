INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::Rosella::ObjectFactory);

class Test::Rosella::ObjectFactory {
    method test_BUILD() {
        $!status.unimplemented("this");
    }

    method create() {
        $!status.unimplemented("this");
    }

    method create_typed() {
        $!status.unimplemented("this");
    }
}
