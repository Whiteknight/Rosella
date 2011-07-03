INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String::Tokenizer::Token);

class Test::String::Tokenizer::Token {
    method test_BUILD() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::Token, "", "", "");
        $!assert.not_null($t);
    }

    method type_name() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::Token, "test", "foo", "bar");
        $!assert.equal($t.type_name, "test");
    }

    method data() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::Token, "test", "foo", "bar");
        $!assert.equal($t.data, "foo");
    }

    method metadata() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::Token, "test", "foo", "bar");
        $!assert.equal($t.metadata, "bar");
    }
}
