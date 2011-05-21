INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(Test::Query::Queryable);

class Test::Query::Queryable {

    # Helpers

    sub test_hash() {
        my %data := {};
        %data{"foo"} := 1;
        %data{"bar"} := 2;
        %data{"baz"} := 3;
        %data{"fie"} := 4;
        return %data;
    }

    sub arrays_equal($assert, @a, @b) {
        $assert.equal(pir::elements(@a), pir::elements(@b));
        my $i := 0;
        while $i <= pir::elements(@a) {
            $assert.equal(@a[$i], @b[$i]);
            $i++;
        }
    }

    sub hashes_equal($assert, %a, %b) {
        $assert.equal(pir::elements(%a), pir::elements(%b));
        $assert.throws_nothing({
            for %a -> $key {
                pir::print($key);
                pir::print(": ");
                say(%a{$key});
                say(%b{$key});
                #say("$key: " ~ %a{$key});
                $assert.equal(%a{$key}, %b{$key});
            }
        });
    }

    sub hash(*%args) { %args; }

    # Methods

    method test_BUILD() {
        my @data := <1, 2, 3, 4>;
        my $q := Rosella::construct(Rosella::Query::Queryable, @data);
    }

    method test_BUILD_provider() {
        $!status.unimplemented("Need test to build a Queryable with custom Provider");
    }

    method get_provider() {
        my %hash := {};
        my @array := [];
        my $q := Rosella::construct(Rosella::Query::Queryable, @array);

        my $p := $q.get_provider(%hash);
        $!assert.instance_of($p, Rosella::Query::Provider::Hash);

        $p := $q.get_provider(@array);
        $!assert.instance_of($p, Rosella::Query::Provider::Array);

        $p := $q.get_provider(1);
        $!assert.instance_of($p, Rosella::Query::Provider::Scalar);
    }

    method data() {
        my @data := <foo bar baz fie>;
        my @new_data := Rosella::Query::as_queryable(@data).data();
        $!assert.same(@data, @new_data);
    }

    method as_queryable() {
        my @data := <1, 2, 3, 4>;
        my $q := Rosella::construct(Rosella::Query::Queryable, @data);
        my $new_q := $q.as_queryable(@data);
        $!assert.instance_of($new_q, Rosella::Query::Queryable);
        $!assert.not_same($q, $new_q);
    }

    # map

    method test_map_hash() {
        my %data := test_hash();
        my %new_data := Rosella::Query::as_queryable(%data).map(-> $item { "($item)"; }).data();
        $!assert.equal(%new_data{"foo"}, "(1)");
        $!assert.equal(%new_data{"bar"}, "(2)");
        $!assert.equal(%new_data{"baz"}, "(3)");
        $!assert.equal(%new_data{"fie"}, "(4)");
    }

    method test_map_array() {
        my @data := <foo bar baz fie>;
        my @new_data := Rosella::Query::as_queryable(@data).map(-> $item { "($item)"; }).data();
        $!assert.equal(pir::elements(@new_data), 4);
        $!assert.equal(@new_data[0], "(foo)");
        $!assert.equal(@new_data[1], "(bar)");
        $!assert.equal(@new_data[2], "(baz)");
        $!assert.equal(@new_data[3], "(fie)");
    }

    method test_map_scalar() {
        my $new_data := Rosella::Query::as_queryable(1).map(-> $item { "($item)"; }).data();
        $!assert.equal($new_data, "(1)");
    }

    # filter

    method test_filter_hash() {
        my %data := test_hash();
        my %new_data := Rosella::Query::as_queryable(%data).filter(
            -> $item { $item % 2 == 0; }
        ).data();
        $!assert.equal(pir::elements(%new_data), 2);
        $!assert.equal(%new_data{"bar"}, 2);
        $!assert.equal(%new_data{"fie"}, 4);
    }

    method test_filter_array() {
        my @data := <foo bar baz fie>;
        my @new_data := Rosella::Query::as_queryable(@data).filter(
                -> $item { pir::substr($item, 0, 1) eq 'f'; }
            ).data();
        $!assert.equal(pir::elements(@new_data), 2);
        $!assert.equal(@new_data[0], "foo");
        $!assert.equal(@new_data[1], "fie");
    }

    method test_filter_scalar() {
        $!status.unimplemented("Need test for .filter(scalar)");
    }

    # fold

    method test_fold_hash() {
        my %data := test_hash();
        my $new_data := Rosella::Query::as_queryable(%data).fold(-> $s, $i { $s + $i; }).data();
        $!assert.equal($new_data, 10);
    }

    method test_fold_array() {
        my @data := [1, 2, 3, 4];
        my $new_data := Rosella::Query::as_queryable(@data).fold(-> $s, $i { $s + $i; }).data();
        $!assert.equal($new_data, 10);
    }

    method test_fold_scalar() {
        my $data := 2;
        my $new_data := Rosella::Query::as_queryable($data).fold(-> $s, $i { $s + $i; }).data();
        $!assert.equal($new_data, 2);
    }

    # count

    method test_count_hash() {
        my %data := test_hash();
        my $count := Rosella::Query::as_queryable(%data).count();
        $!assert.equal($count, 4);

        $count := Rosella::Query::as_queryable(%data).count(sub($a) { return $a % 2 });
        $!assert.equal($count, 2);
    }

    method test_count_array() {
        my @data := [1, 2, 3, 4];
        my $count := Rosella::Query::as_queryable(@data).count();
        $!assert.equal($count, 4);

        $count := Rosella::Query::as_queryable(@data).count(sub($a) { return $a % 2 });
        $!assert.equal($count, 2);
    }

    method test_count_scalar() {
        my $count := Rosella::Query::as_queryable(1).count();
        $!assert.equal($count, 1);
    }

    # take

    method test_take_hash() {
        $!status.unimplemented("tests for .take()");
    }

    method test_take_array() {
        $!status.unimplemented("tests for .take()");
    }

    method test_take_scalar() {
        $!status.unimplemented("tests for .take()");
    }

    # skip

    method test_skip_hash() {
        $!status.unimplemented("tests for .skip()");
    }

    method test_skip_array() {
        $!status.unimplemented("tests for .skip()");
    }

    method test_skip_scalar() {
        $!status.unimplemented("tests for .skip()");
    }

    # to_array

    method test_to_array_hash() {
        my %data := test_hash();
        my @array := Rosella::Query::as_queryable(%data).to_array.data;
        arrays_equal($!assert, @array, [1, 2, 3, 4]);
    }

    method test_to_array_array() {
        my @data := <foo bar baz fie>;
        my @new_data := Rosella::Query::as_queryable(@data).to_array.data;
        $!assert.not_same(@data, @new_data);
    }

    method test_to_array_scalar() {
        my @array := Rosella::Query::as_queryable(1).to_array.data;
        arrays_equal($!assert, @array, [1]);
    }

    # to_hash

    method test_to_hash_hash() {
        my %data := test_hash();
        my %hash := Rosella::Query::as_queryable(%data).to_hash(
            -> $item { "test_$item"; }
        ).data;
        hashes_equal($!assert, %hash, hash(:test_foo(1), :test_bar(2), :test_baz(3), :test_fie(4)));
    }

    method test_to_hash_array() {
        my @data := <foo bar baz fie>;
        my %hash := Rosella::Query::as_queryable(@data).to_hash(
            -> $item { "test_$item"; }
        ).data;
        hashes_equal($!assert, %hash, hash(:test_foo("foo"), :test_bar("bar"), :test_baz("baz"), :test_fie("fie")));
    }

    method test_to_hash_scalar() {
        my %hash := Rosella::Query::as_queryable("A").to_hash(
            -> $item { "test_$item"; }
        ).data;
        hashes_equal($!assert, %hash, hash(:test_A("A")));
    }
}
