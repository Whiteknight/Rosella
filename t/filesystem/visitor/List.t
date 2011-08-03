INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "filesystem");
}

Rosella::Test::test(Test::FileSystem::Visitor::List);

class Test::FileSystem::Visitor::List {
    method test_BUILD() {
        $!status.unimplemented("Need to test Visitor.List");
    }

    method process() {
        $!status.unimplemented("Need to test Visitor.List");
    }

    method result() {
        $!status.unimplemented("Need to test Visitor.List");
    }
}
