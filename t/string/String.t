INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String);

class Test::String {
    method get_character_class() {
        $!status.unimplemented("Test this");
    }

    method first_not_cclass() {
        $!status.unimplemented("Test this");
    }

    method last_not_cclass() {
        $!status.unimplemented("Test this");
    }

    method trim_start() {
        $!assert.equal(Rosella::String::trim_start("   test   "), "test   ");
    }

    method trim_start_cclass() {
        $!status.unimplemented("Need test with optional cclass argument");
    }

    method trim_end() {
        $!assert.equal(Rosella::String::trim_end("   test   "), "   test");
    }

    method trim_end_cclass() {
        $!status.unimplemented("Need test with optional cclass argument");
    }

    method trim() {
        $!assert.equal(Rosella::String::trim("   test   "), "test");
    }

    method trim_cclass() {
        $!status.unimplemented("Need test with optional cclass argument");
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
