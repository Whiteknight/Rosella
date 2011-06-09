INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/proxy.pbc");
}

Rosella::Test::test(Test::Proxy::Builder::Passthrough);

class Test::Proxy::Builder::Passthrough {

}
