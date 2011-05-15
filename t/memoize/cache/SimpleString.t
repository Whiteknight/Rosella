INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/memoize.pbc");
}

Rosella::Test::test(Test::Memoize::Cache::SimpleString);

class Test::Memoize::Cache::SimpleString {
    method test_BUILD() {
        $!status.unimplemented("Need test for this");
    }

    method get_item() {
        $!status.unimplemented("Need test for this");
    }

    method remove_item() {
        $!status.unimplemented("Need test for this");
    }

    method clear() {
        $!status.unimplemented("Need test for this");
    }

    method key() {
        $!status.unimplemented("Need test for this");
    }
}
