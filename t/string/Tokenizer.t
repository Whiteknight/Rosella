INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String::Tokenizer);

class Test::String::Tokenizer {
    sub get_tokenizer() {
        return Rosella::construct(Rosella::String::Tokenizer::CClass);
    }

    method add_data() {
        my $t := get_tokenizer();
        $t.add_data("test");
    }

    method set_data() {
        my $t := get_tokenizer();
        $t.set_data("test");
    }

    method get_all_data() {
        my $t := get_tokenizer();
        $t.set_data("test");
        my $d := $t.get_all_data();
        $!assert.equal($d, "test");
        $d := $t.get_all_data();
        $!assert.equal($d, "");
    }

    method map_token() {
        my $t := get_tokenizer();
        $t.map_token("foo", "test", "bar");
        $t.set_data("test");
        my $k := $t.get_token;
        $!assert.equal($k.data, "test");
        $!assert.equal($k.metadata, "bar");
        $!assert.equal($k.type_name, "foo");
    }

    method has_tokens() {
        my $t := get_tokenizer();
        $!assert.is_false($t.has_tokens);
        $t.set_data("test");
        $!assert.is_true($t.has_tokens);
        $t.get_all_data();
        $!assert.is_false($t.has_tokens);
    }

    method get_token() {
        my $t := get_tokenizer();
        my $d := $t.get_token;
        $!assert.is_null($d);
        $t.set_data("test");
        $d := $t.get_token;
        $!assert.not_null($d);
    }

    method unget_token() {
        my $t := get_tokenizer();
        $t.set_data("test");
        my $k := $t.get_token;
        $!assert.is_false($t.has_tokens);
        $t.unget_token($k);
        $!assert.is_true($t.has_tokens);
        $k := $t.get_token;
        $!assert.equal($k.data, "test");
    }

    method all_tokens() {
        my $t := get_tokenizer();
        $t.set_data("test   123   fooo");
        my @k := $t.all_tokens;
        $!assert.equal(+@k, 5);
    }
}
