INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

Rosella::Test::test(Test::TestStatus::Test);

class Test::TestStatus::Test {
    method test_current_test() {
        my $teststatus := Rosella::construct(Rosella::Test::TestStatus, "TestName", "TestMethod", "Suite");
        $!assert.equal($teststatus.current_test(), "TestMethod");
    }

    method test_todo() {
        $!status.unimplemented("Find a way to test TestContext.todo()");
    }

    method test_verify() {
        $!status.unimplemented("Find a way to test TestContext.verify()");
    }

    method test_unimplemented() {
        $!status.unimplemented("Find a way to test TestContext.unimplemented()");
    }
}
