INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "string");
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

    method get_tokens_no_content() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::Delimiter, ",");
        $t.add_data(",,");
        $!assert.equal($t.get_token.data, "");
        $!assert.equal($t.get_token.data, "");
        $!assert.is_false($t.has_tokens);
    }
}
