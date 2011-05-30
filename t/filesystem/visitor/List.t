INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
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
