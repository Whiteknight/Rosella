INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(Test::Query::Provider);

class Test::Query::Provider {
    method map() {
    }

    method filter() {
    }

    method fold() {
    }

    method count() {
    }

    method any() {
    }

    method single() {
    }

    method first() {
    }

    method first_or_default() {
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
