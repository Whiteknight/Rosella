INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String);

class Test::String {
    method get_character_class() {
        my $cc := Rosella::String::get_character_class("whitespace");
        $!assert.not_equal($cc, 0);
        $cc := Rosella::String::get_character_class("word");
        $!assert.not_equal($cc, 0);
        $cc := Rosella::String::get_character_class("numeric");
        $!assert.not_equal($cc, 0);
        $cc := Rosella::String::get_character_class("graphical");
        $!assert.not_equal($cc, 0);
        $cc := Rosella::String::get_character_class("punctuation");
        $!assert.not_equal($cc, 0);
        $!assert.throws({
            $cc := Rosella::String::get_character_class("LOL whatever");
        });
    }

    method first_not_cclass() {
        my $i := Rosella::String::first_not_cclass("   test", Rosella::String::get_character_class("whitespace"));
        $!assert.equal($i, 3);
        $i := Rosella::String::first_not_cclass("   ", Rosella::String::get_character_class("whitespace"));
        $!assert.equal($i, -1);
    }

    method last_not_cclass() {
        my $i := Rosella::String::last_not_cclass("test   ", Rosella::String::get_character_class("whitespace"));
        $!assert.equal($i, 4);
        $i := Rosella::String::last_not_cclass("   ", Rosella::String::get_character_class("whitespace"));
        $!assert.equal($i, -1);
    }

    method trim_start() {
        $!assert.equal(Rosella::String::trim_start("   test   "), "test   ");
    }

    method trim_start_cclass() {
        my $s := Rosella::String::trim_start("   test   ", Rosella::String::get_character_class("whitespace"));
        $!assert.equal($s, "test   ");
        $s := Rosella::String::trim_start("   test   ", Rosella::String::get_character_class("word"));
        $!assert.equal($s, "   test   ");
    }

    method trim_end() {
        $!assert.equal(Rosella::String::trim_end("   test   "), "   test");
    }

    method trim_end_cclass() {
        my $s := Rosella::String::trim_end("   test   ", Rosella::String::get_character_class("whitespace"));
        $!assert.equal($s, "   test");
        $s := Rosella::String::trim_end("   test   ", Rosella::String::get_character_class("word"));
        $!assert.equal($s, "   test   ");
    }

    method trim() {
        $!assert.equal(Rosella::String::trim("   test   "), "test");
    }

    method trim_cclass() {
        my $s := Rosella::String::trim("   test   ", Rosella::String::get_character_class("whitespace"));
        $!assert.equal($s, "test");
        $s := Rosella::String::trim_end("   test   ", Rosella::String::get_character_class("word"));
        $!assert.equal($s, "   test   ");
    }

    method sprintf() {
        $!assert.equal(Rosella::String::sprintf("%d %f %s", 1, 3.14, "test"), pir::sprintf__SSP("%d %f %s", [1, 3.14, "test"]));
    }

    method pad_start() {
        $!assert.equal(Rosella::String::pad_start("test", 6), "  test");
    }

    method pad_start_char() {
        $!assert.equal(Rosella::String::pad_start("test", 6, "A"), "AAtest");
    }

    method pad_end() {
        $!assert.equal(Rosella::String::pad_end("test", 6), "test  ");
    }

    method pad_end_char() {
        $!assert.equal(Rosella::String::pad_end("test", 6, "A"), "testAA");
    }

    method remove_start() {
        $!assert.equal(Rosella::String::remove_start("test", 2), "st");
    }

    method remove_end() {
        $!assert.equal(Rosella::String::remove_end("test", 2), "te");
    }

    method remove_middle() {
        $!assert.equal(Rosella::String::remove_middle("test", 1, 2), "tt");
    }

    method replace_all() {
        $!assert.equal(Rosella::String::replace_all("test", "est", "ask"), "task");
    }

    method replace_first() {
        $!status.unimplemented("Test this");
    }

    method replace_skip() {
        $!status.unimplemented("Test this");
    }

    method indexof_start() {
        $!status.unimplemented("Test this");
    }

    method indexof_end() {
        $!status.unimplemented("Test this");
    }
}
