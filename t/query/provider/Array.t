INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "query");
}

Rosella::Test::test(Test::Query::Provider::Array);

class Test::Query::Provider::Array {

    sub arrays_equal($assert, @a, @b) {
        $assert.equal(pir::elements(@a), pir::elements(@b));
        $assert.throws_nothing({
            my $i := 0;
            while $i < pir::elements(@a) {
                $assert.equal(@a[$i], @b[$i]);
                $i++;
            }
        });
    }

    method map() {
        my @data := [1, 2, 3, 4];
        my @result := Rosella::Query::as_queryable(@data).map(
            -> $i { $i + 5; }
        ).data;
        arrays_equal($!assert, @result, [6, 7, 8, 9]);
    }

    method filter() {
        my @data := [1, 2, 3, 4];
        my @result := Rosella::Query::as_queryable(@data).filter(
            -> $i { $i % 2; }
        ).data;
        arrays_equal($!assert, @result, [1, 3]);
    }

    method fold() {
        my @data := [1, 2, 3, 4];
        my $result := Rosella::Query::as_queryable(@data).fold(
            -> $s, $i { $i + $s; }
        ).data;
        $!assert.equal($result, 10);
    }

    method take() {
        my @data := [1, 2, 3, 4];
        my $result := Rosella::Query::as_queryable(@data).take(1).data;
        arrays_equal($!assert, $result, [1]);
    }

    method take_two() {
        my @data := [1, 2, 3, 4];
        my $result := Rosella::Query::as_queryable(@data).take(2).data;
        arrays_equal($!assert, $result, [1, 2]);
    }

    method take_predicate() {
        my @data := [1, 2, 3, 4];
        my @result := Rosella::Query::as_queryable(@data).take(1,
            -> $i { $i > 2; }
        ).data;
        arrays_equal($!assert, @result, [3]);
    }

    method skip() {
        my @data := [1, 2, 3, 4];
        my @result := Rosella::Query::as_queryable(@data).skip(1).data;
        arrays_equal($!assert, @result, [2, 3, 4]);
    }

    method skip_predicate() {
        my @data := [1, 2, 3, 4];
        my @result := Rosella::Query::as_queryable(@data).skip(1,
            -> $i { $i % 2 == 0; }
        ).data;
        arrays_equal($!assert, @result, [4]);
    }

    method to_array() {
        my @data := [1, 2, 3, 4];
        my @result := Rosella::Query::as_queryable(@data).to_array.data;
        arrays_equal($!assert, @result, @data);
        $!assert.not_same(@result, @data);
    }

    method to_hash() {
        my @data := [1, 2, 3, 4];
        my %result := Rosella::Query::as_queryable(@data).to_hash(
            -> $i { "test_$i"; }
        ).data;
        $!assert.does(%result, "hash");
        $!assert.equal(pir::elements(%result), 4);
        $!assert.equal(%result{"test_1"}, 1);
        $!assert.equal(%result{"test_2"}, 2);
        $!assert.equal(%result{"test_3"}, 3);
        $!assert.equal(%result{"test_4"}, 4);
    }
}
