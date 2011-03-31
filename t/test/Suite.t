INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/mockobject.pbc");
}

Rosella::Test::test(Test::Suite::Test);

class MyFakeTest {
    method test_one() {}
    method test_two() {}
    method test_three() {}
}

class MyFakeSubTest is MyFakeTest {
    method test_one() {}
    method test_four() {}
}

class Test::Suite::Test {
    method test_BUILD() {
        my $suite := Rosella::build(Rosella::Test::Suite, [], "suite");
        Assert::not_null($suite);
    }

    method test_default_result() {
        my $suite := Rosella::build(Rosella::Test::Suite, [], "suite");
        my $result := $suite.default_result();
        Assert::equal(~(pir::typeof__SP($result)), "Rosella;Test;Result");
    }

    method test_run() {
        $!status.unimplemented("Find a way to test Suite.run()");
    }

    method test_run_test() {
        $!status.unimplemented("Find a way to test Suite.run_test()");
    }
}
