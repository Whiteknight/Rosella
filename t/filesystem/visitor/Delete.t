INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "filesystem");
}

Rosella::Test::test(Test::FileSystem::Visitor::Delete);

class Test::FileSystem::Visitor::Delete {
    method test_BUILD() {
        $!status.unimplemented("Need to test Visitor.Delete");
    }

    method visit_file() {
        $!status.unimplemented("Need to test Visitor.Delete");
    }

    method end_directory() {
        $!status.unimplemented("Need to test Visitor.Delete");
    }

    method result() {
        $!status.unimplemented("Need to test Visitor.Delete");
    }
}
