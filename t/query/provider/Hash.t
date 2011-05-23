INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(Test::Query::Provider::Hash);

class Test::Query::Provider::Hash {
    sub hash(*%n) { %n; }

    sub hashes_equal($assert, %a, %b) {
        $assert.equal(pir::elements(%a), pir::elements(%b));
        $assert.throws_nothing({
            for %a -> $key {
                $assert.equal(%a{$key}, %b{$key});
            }
        });
    }

    method map() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %new_data := Rosella::Query::as_queryable(%data).map(
            -> $i { $i + 5 }
        ).data;
        hashes_equal($!assert, %new_data, hash(:foo(6), :bar(7), :baz(8)));
    }

    method filter() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %new_data := Rosella::Query::as_queryable(%data).filter(
            -> $i { $i % 2 }
        ).data;
        hashes_equal($!assert, %new_data, hash(:foo(1), :baz(3)));
    }

    method fold() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my $result := Rosella::Query::as_queryable(%data).fold(
            -> $s, $i { $i + $s }
        ).data;
        $!assert.equal($result, 6);
    }

    method take() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).take(1).data;
        $!assert.equal(pir::elements(%result), 1);
    }

    method take_predicate() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).take(1,
            -> $i { $i == 1 }
        ).data;
        $!assert.equal(pir::elements(%result), 1);
    }

    method take_bad_predicate() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).take(1,
            -> $i { $i == 40 }
        ).data;
        $!assert.equal(pir::elements(%result), 0);
    }

    method take_zero_predicate() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).take(0,
            -> $i { $i == 1 }
        ).data;
        $!assert.equal(pir::elements(%result), 0);
    }

    method take_too_many() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).take(30).data;
        $!assert.equal(pir::elements(%result), 3);
    }

    method take_too_many_predicate() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).take(30,
            -> $i { $i == 1 }
        ).data;
        $!assert.equal(pir::elements(%result), 1);
    }

    method skip() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).skip(1).data;
        $!assert.equal(pir::elements(%result), 2);
    }

    method skip_zero() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).skip(0).data;
        $!assert.equal(pir::elements(%result), 3);
    }

    method skip_two() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).skip(2).data;
        $!assert.equal(pir::elements(%result), 1);
    }

    method skip_predicate() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).skip(1,
            -> $i { $i % 2 }
        ).data;
        $!assert.equal(pir::elements(%result), 1);
    }

    method skip_predicate_zero() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).skip(0,
            -> $i { $i % 2 }
        ).data;
        $!assert.equal(pir::elements(%result), 2);
    }

    method unwrap_first() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my $p := Rosella::construct(Rosella::Query::Provider::Hash);
        my $result := $p.unwrap_first(%data);
        $!assert.instance_of($result, 'Integer');
    }

    method to_array() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my @result := Rosella::Query::as_queryable(%data).to_array.data;
        $!assert.does(@result, 'array');
    }

    method to_hash() {
        my %data := hash(:foo(1), :bar(2), :baz(3));
        my %result := Rosella::Query::as_queryable(%data).to_hash.data;
        $!
    }
}
