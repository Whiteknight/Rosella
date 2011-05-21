INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String::Tokenizer::CClass);

class Test::String::Tokenizer::CClass {
    method test_BUILD() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
    }

    method add_data() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        $cc.add_data("test");
    }

    method map_token() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        $cc.map_token("test", "testvalue");
        $cc.add_data("test");
        my $t := $cc.next_token;
        $!assert.equal($t.data, "test");
        $!assert.equal($t.metadata, "testvalue");
    }

    method has_tokens() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        $!assert.is_false($cc.has_tokens);
    }

    method next_token() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        $cc.add_data("test");
        my $t := $cc.next_token;
        $!assert.equal($t.data, "test");
    }

    method get_token() {
    }

    method get_token_mapped() {
    }

    method build_token() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        my $t := $cc.build_token("Foo", "Bar");
        $!assert.equal($t.data, "Foo");
        $!assert.equal($t.metadata, "Bar");
    }

    method lex_next_token() {
    }

    method unget_token() {
    }
}
