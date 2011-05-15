INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/memoize.pbc");
}

Rosella::Test::test(Test::Memoize::Cache::Item);

class Test::Memoize::Cache::Item {
    method test_BUILD() {
    }

    method has_value() {
    }

    method update_value() {
    }

    method get_value() {
    }
}
