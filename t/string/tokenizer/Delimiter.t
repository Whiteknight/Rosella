INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String::Tokenizer::Delimiter);

class Test::String::Tokenizer::Delimiter {
    method test_BUILD() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::Delimiter, ",");
        $!assert.not_null($t);
    }

    method get_tokens() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::Delimiter, ",");
        $t.add_data("foo,bar,baz");
        $!assert.equal($t.get_token.data, "foo");
        $!assert.equal($t.get_token.data, "bar");
        $!assert.equal($t.get_token.data, "baz");
    }
}
