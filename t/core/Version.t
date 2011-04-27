INIT {
    pir::load_bytecode("rosella/core.pbc");
    pir::load_bytecode("rosella/test.pbc");
}

Rosella::Test::test(Test::Rosella::Version);

class Test::Rosella::Version {
    method nonexistant_version() {
        my $ver := Rosella::get_version("BlahBlahBlah - does not exist");
        $!assert.equal(+$ver, -1);
    }
}
