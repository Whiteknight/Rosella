INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(QueryTest);

class QueryTest {
    method test_map_hash() {
        my %data := {};
        %data{"foo"} := 1;
        %data{"bar"} := 2;
        %data{"baz"} := 3;
        %data{"fie"} := 4;
        my %new_data := Rosella::Query::map(%data, sub($item) { return "($item)"; });
        $!assert.equal(%new_data{"foo"}, "(1)");
        $!assert.equal(%new_data{"bar"}, "(2)");
        $!assert.equal(%new_data{"baz"}, "(3)");
        $!assert.equal(%new_data{"fie"}, "(4)");
    }

    method test_map_array() {
        my @data := <foo bar baz fie>;
        my @new_data := Rosella::Query::map(@data, sub($item) { return "($item)"; });
        $!assert.equal(pir::elements(@new_data), 4);
        $!assert.equal(@new_data[0], "(foo)");
        $!assert.equal(@new_data[1], "(bar)");
        $!assert.equal(@new_data[2], "(baz)");
        $!assert.equal(@new_data[3], "(fie)");
    }

    method test_filter_hash() {
        my %data := {};
        %data{"foo"} := 1;
        %data{"bar"} := 2;
        %data{"baz"} := 3;
        %data{"fie"} := 4;
        my %new_data := Rosella::Query::filter(%data,
            sub($item) {
                return $item % 2 == 0;
            }
        );
        $!assert.equal(pir::elements(%new_data), 2);
        $!assert.equal(%new_data{"bar"}, 2);
        $!assert.equal(%new_data{"fie"}, 4);
    }

    method test_filter_array() {
        my @data := <foo bar baz fie>;
        my @new_data := Rosella::Query::filter(@data,
            sub($item) {
                return pir::substr($item, 0, 1) eq 'f';
            }
        );
        $!assert.equal(pir::elements(@new_data), 2);
        $!assert.equal(@new_data[0], "foo");
        $!assert.equal(@new_data[1], "fie");
    }
}
