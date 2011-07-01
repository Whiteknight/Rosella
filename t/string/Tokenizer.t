INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String::Tokenizer);

class Test::String::Tokenizer {
    method test_BUILD() {
        $!status.unimplemented("Test this");
    }

    method add_data() {
        $!status.unimplemented("Test this");
    }

    method map_token() {
        $!status.unimplemented("Test this");
    }

    method has_tokens() {
        $!status.unimplemented("Test this");
    }

    method next_token() {
        $!status.unimplemented("Test this");
    }

    method get_token() {
        $!status.unimplemented("Test this");
    }

    method build_token() {
        $!status.unimplemented("Test this");
    }

    method lex_next_token() {
        $!status.unimplemented("Test this");
    }

    method unget_token() {
        $!status.unimplemented("Test this");
    }
}
