INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/filesystem.pbc");
}

Rosella::Test::test(Test::FileSystem::Visitor::List);

class Test::FileSystem::Visitor::List {
    method test_BUILD() {
    }

    method process() {
    }

    method result() {
    }
}
