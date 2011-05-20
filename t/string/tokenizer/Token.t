INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String::Tokenizer::Token);

class Test::String::Tokenizer::Token {
    method test_BUILD() {
    }

    method data() {
    }

    method metadata() {
    }
}
