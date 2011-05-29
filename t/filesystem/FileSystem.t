INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem);

class Test::FileSystem {
    method get_os_pmc() {
    }

    method is_file() {
    }

    method is_directory() {
    }

    method path_separator() {
    }
}
