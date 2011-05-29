INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem::Directory);

class Test::FileSystem::Directory {
    method current_directory() {
    }

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

    method delete_recursive() {
    }

    method create() {
    }

    method get_files() {
    }

    method get_subdirectories() {
    }

    method walk() {
    }

    method walk_func() {
    }
}
