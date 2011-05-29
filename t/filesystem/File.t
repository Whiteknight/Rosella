INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem::File);

class Test::FileSystem::File {
    method test_BUILD() {
    }

    method exists() {
    }

    method delete() {
    }

    method get_string() {
    }

    method rename() {
    }

    method short_name() {
    }

    method open_read() {
    }

    method open_write() {
    }

    method open_append() {
    }

    method read_all_text() {
    }

    method read_all_lines() {
    }

    method write_all_text() {
    }

    method write_all_lines() {
    }

    method append_text() {
    }

    method copy() {
    }
}
