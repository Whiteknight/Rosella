INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(Test::Query::Provider::Array);

class Test::Query::Provider::Array {
    method map() {
    }

    method filter() {
    }

    method fold() {
    }

    method take() {
    }

    method skip() {
    }

    method to_array() {
    }

    method to_hash() {
    }
}
