INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::Rosella::Globals);

class Test::Rosella::Globals {
    method get_global() {
        $!status.unimplemented("this");
    }

    method register_global() {
        $!status.unimplemented("this");
    }

    method get_default_factory() {
        $!status.unimplemented("this");
    }
}
