INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "filesystem");
}

Rosella::Test::test(Test::FileSystem::Visitor::Function);

class Test::FileSystem::Visitor::Function {
    method test_BUILD() {
        $!status.unimplemented("Need to test Visitor.Function");
    }

    method should_visit() {
        $!status.unimplemented("Need to test Visitor.Function");
    }

    method process() {
        $!status.unimplemented("Need to test Visitor.Function");
    }

    method result() {
        $!status.unimplemented("Need to test Visitor.Function");
    }
}
