INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem::Entry);

class Test::FileSystem::Entry {
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
}
