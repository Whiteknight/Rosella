INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String::Tokenizer::DelimiterRegion);

class Test::String::Tokenizer::DelimiterRegion {
    method test_BUILD() {
        $!status.unimplemented("Test this!");
    }

    method get_tokens() {
        $!status.unimplemented("Test this!");
    }


}
