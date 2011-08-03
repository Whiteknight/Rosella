INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "query");
}

Rosella::Test::test(Test::Query::Provider);

class Test::Query::Provider {
    method map() {
    }

    method filter() {
    }

    method fold() {
    }

    method sort() {
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

    method unwrap_first() {
    }

    method to_array() {
    }

    method to_hash() {
    }
}
