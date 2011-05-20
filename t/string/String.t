INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/string.pbc");
}

Rosella::Test::test(Test::String);

class Test::String {
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

    method pad_left() {
        $!assert.equal(Rosella::String::pad_left("test", 6), "  test");
    }

    method pad_left_char() {
        $!assert.equal(Rosella::String::pad_left("test", 6, "A"), "AAtest");
    }

    method pad_right() {
        $!assert.equal(Rosella::String::pad_right("test", 6), "test  ");
    }

    method pad_right_char() {
        $!assert.equal(Rosella::String::pad_right("test", 6, "A"), "testAA");
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

    method replace() {
        $!assert.equal(Rosella::String::replace("test", "est", "ask"), "task");
    }
}
