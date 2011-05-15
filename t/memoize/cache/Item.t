INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/memoize.pbc");
}

Rosella::Test::test(Test::Memoize::Cache::Item);

class Test::Memoize::Cache::Item {
    method test_BUILD() {
        $!status.unimplemented("Need test for this");
    }

    method has_value() {
        $!status.unimplemented("Need test for this");
    }

    method update_value() {
        $!status.unimplemented("Need test for this");
    }

    method get_value() {
        $!status.unimplemented("Need test for this");
    }
}
