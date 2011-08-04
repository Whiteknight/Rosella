INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "filesystem");
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
