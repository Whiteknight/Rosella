INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "filesystem");
}

Rosella::Test::test(Test::FileSystem::Visitor);

class Test::FileSystem::Visitor {
    method test_BUILD() {
        $!status.unimplemented("Need to test Visitor");
    }

    method visit_file() {
        $!status.unimplemented("Need to test Visitor");
    }

    method should_visit() {
        $!status.unimplemented("Need to test Visitor");
    }

    method process() {
        $!status.unimplemented("Need to test Visitor");
    }

    method begin_directory() {
        $!status.unimplemented("Need to test Visitor");
    }

    method end_directory() {
        $!status.unimplemented("Need to test Visitor");
    }

    method result() {
        $!status.unimplemented("Need to test Visitor");
    }
}
