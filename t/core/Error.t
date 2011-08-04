INIT {
    my $core := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(ErrorTest);

class ErrorTest {
    method test_fail() {
        $!status.unimplemented("Test this");
    }
}
