INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "proxy");
}

Rosella::Test::test(Test::Proxy::Builder::Passthrough);

class Test::Proxy::Builder::Passthrough {

}
