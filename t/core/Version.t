INIT {
    my $core := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::Rosella::Version);

class Test::Rosella::Version {
    method nonexistant_version() {
        my $ver := Rosella::Version::get_version("BlahBlahBlah - does not exist");
        $!assert.equal(+$ver.library_version(), -1);
        $!assert.equal($ver.library_state(), "UNKNOWN");
    }
}
