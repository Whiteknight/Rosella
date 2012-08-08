INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "string");
}

Rosella::Test::test(Test::String::Tokenizer::DelimiterRegion);

class Test::String::Tokenizer::DelimiterRegion {
    method test_BUILD() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::DelimiterRegion, "test");
        $!assert.not_null($t);
    }

    method add_region() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::DelimiterRegion, "foo");
        $t.add_region("<", ">", "bar");
    }

    method get_tokens() {
        my $t := Rosella::construct(Rosella::String::Tokenizer::DelimiterRegion, "foo");
        $t.add_region("<", ">", "bar");
        $t.add_data("this is <b>bold</b>");
        $!assert.equal($t.get_token.data, "this is ");
        $!assert.equal($t.get_token.data, "b");
        $!assert.equal($t.get_token.data, "bold");
        $!assert.equal($t.get_token.data, "/b");
    }

    method get_tokens_unclosed_region() {
        $!assert.throws({
            my $t := Rosella::construct(Rosella::String::Tokenizer::DelimiterRegion, "foo");
            $t.add_region("<", ">", "bar");
            $t.add_data("this is <b");
            $t.get_token.data;
            $t.get_token.data;
        });
    }
}
