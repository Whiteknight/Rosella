INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "query");
}

Rosella::Test::test(Test::Query::Queryable::Chaining);

class Test::Query::Queryable::Chaining {
    sub data(*@args) { @args; }

    method sum_of_odd_squares() {
        my @data := data(1, 2, 3, 4, 5, 6, 7, 8, 9);
        my $sum := Rosella::Query::as_queryable(@data, 1).map(
            -> $i { $i * $i; }
        ).filter(
            -> $j { $j % 2; }
        ).fold(
            -> $s, $i { $s + $i; }
        ).data();
        $!assert.equal($sum, 165);
    }
}
