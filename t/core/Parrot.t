INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::Rosella::Parrot);

class Test::Rosella::Parrot {
    method get_config_hash() {
        $!status.unimplemented("this");
    }

    method get_backtrace_strings() {
        $!status.unimplemented("this");
    }

    method get_backtrace_ex_strings() {
        $!status.unimplemented("this");
    }

    method try_report() {
        $!status.unimplemented("this");
    }
}
