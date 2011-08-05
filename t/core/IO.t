INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::Rosella::IO);

class Test::Rosella::IO {
    method swap_handles() {
        $!status.unimplemented("this");
    }

    method sayf() {
        $!status.unimplemented("this");
    }

    method printf() {
        $!status.unimplemented("this");
    }
}
