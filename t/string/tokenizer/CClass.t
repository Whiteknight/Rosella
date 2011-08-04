INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "string");
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
        $cc.map_token("typename", "test", "testvalue");
        $cc.add_data("test");
        my $t := $cc.get_token;
        $!assert.equal($t.type_name, "typename");
        $!assert.equal($t.data, "test");
        $!assert.equal($t.metadata, "testvalue");
    }

    method has_tokens() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        $!assert.is_false($cc.has_tokens);
    }

    method get_token() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        $cc.add_data("test");
        my $t := $cc.get_token;
        $!assert.equal($t.data, "test");
    }

    method __build_token() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        my $t := $cc.__build_token("TypeName", "Foo", "Bar");
        $!assert.equal($t.type_name, "TypeName");
        $!assert.equal($t.data, "Foo");
        $!assert.equal($t.metadata, "Bar");
    }

    method lex_next_token() {
        my $cc := Rosella::construct(Rosella::String::Tokenizer::CClass);
        $cc.set_data("foo = bar + baz");
        $!assert.equal($cc.get_token().data(), "foo");
        $!assert.equal($cc.get_token().data(), " ");
        $!assert.equal($cc.get_token().data(), "=");
        $!assert.equal($cc.get_token().data(), " ");
        $!assert.equal($cc.get_token().data(), "bar");
        $!assert.equal($cc.get_token().data(), " ");
        $!assert.equal($cc.get_token().data(), "+");
        $!assert.equal($cc.get_token().data(), " ");
        $!assert.equal($cc.get_token().data(), "baz");
    }

}
