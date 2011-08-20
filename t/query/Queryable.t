INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "query");
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

    # sort

    method test_sort_hash() {
        my %data := hash(:foo(3), :bar(5), :baz(2));
        my @new_data := Rosella::Query::as_queryable(%data).sort(
            -> $i, $j {
                my $result := -1;
                if ($i > $j) { $result := 1; }
                elsif ($i == $j) { $result := 0; }
                $result;
            }
        ).data;
        arrays_equal($!assert, @new_data, [2, 3, 5]);
    }

    method test_sort_array() {
        my @data := [3, 5, 2, 4, 1];
        my @new_data := Rosella::Query::as_queryable(@data).sort(
            -> $i, $j {
                my $result := -1;
                if ($i > $j) { $result := 1; }
                elsif ($i == $j) { $result := 0; }
                $result;
            }
        ).data;
        arrays_equal($!assert, @new_data, [1, 2, 3, 4, 5]);
    }

    method test_sort_scalar() {
        my $data := 1;
        my @new_data := Rosella::Query::as_queryable($data).sort(
            -> $i, $j {
                my $result := -1;
                if ($i > $j) { $result := 1; }
                elsif ($i == $j) { $result := 0; }
                $result;
            }
        ).data;
        arrays_equal($!assert, @new_data, [1]);
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

    # any

    method test_any_hash() {
        my $any := Rosella::Query::as_queryable(test_hash()).any(-> $x { $x == 4 });
        $!assert.is_true($any);
        $any := Rosella::Query::as_queryable(test_hash()).any(-> $x { $x == 5 });
        $!assert.is_false($any);
    }

    method test_any_array() {
        my $any := Rosella::Query::as_queryable([1, 2, 3, 4]).any(-> $x { $x == 4 });
        $!assert.is_true($any);
        $any := Rosella::Query::as_queryable([1, 2, 3, 4]).any(-> $x { $x == 5 });
        $!assert.is_false($any);
    }

    method test_any_scalar() {
        $!status.unimplemented("tests for .any()");
    }

    # take

    method test_take_hash() {
        my %r := Rosella::Query::as_queryable(test_hash()).take(3).data;
        $!assert.equal(+%r, 3);
    }

    method test_take_array() {
        my @r := Rosella::Query::as_queryable([1, 2, 3, 4]).take(3).data;
        $!assert.equal(+@r, 3);
        arrays_equal($!assert, @r, [1, 2, 3]);
    }

    method test_take_scalar() {
        $!status.unimplemented("tests for .take()");
    }

    # skip

    method test_skip_hash() {
        my %r := Rosella::Query::as_queryable(test_hash()).skip(3).data;
        $!assert.equal(+%r, 1);
    }

    method test_skip_array() {
        my @r := Rosella::Query::as_queryable([1, 2, 3, 4]).skip(3).data;
        $!assert.equal(+@r, 1);
        arrays_equal($!assert, @r, [4]);
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
        hashes_equal($!assert, %hash, hash(:test_1(1), :test_2(2), :test_3(3), :test_4(4)));
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

    # single

    method test_single_hash() {
        #my $r := Rosella::Query::as_queryable([1]).single.data;
        #$!assert.equal($r, 1);
        $!assert.throws({
            my $s := Rosella::Query::as_queryable(test_hash()).single;
        })
    }

    method test_single_array() {
        my $r := Rosella::Query::as_queryable([1]).single.data;
        $!assert.equal($r, 1);
        $!assert.throws({
            my $s := Rosella::Query::as_queryable([1, 2, 3, 4]).single;
        })
    }

    method test_single_scalar() {
        $!status.unimplemented("tests for .single()");
    }

    # First

    method test_first_hash() {
        $!assert.throws_nothing({
            my $r := Rosella::Query::as_queryable(test_hash()).first.data;
        });
        $!assert.throws({
            my %h := {};
            my $s := Rosella::Query::as_queryable(%h).first.data;
        });
    }

    method test_first_array() {
        my $r := Rosella::Query::as_queryable([1, 2, 3, 4]).first.data;
        $!assert.equal($r, 1);
        $!assert.throws({
            my $s := Rosella::Query::as_queryable([]).first.data;
        });
    }

    method test_first_scalar() {
        my $r := Rosella::Query::as_queryable("test").first.data;
        $!assert.equal($r, "test");
    }

    # first_or_default

    method test_first_or_default_hash() {
        $!assert.throws_nothing({
            my $r := Rosella::Query::as_queryable(test_hash()).first_or_default.data;
        });
        my %h := {};
        my $s := Rosella::Query::as_queryable(%h).first_or_default.data;
        $!assert.is_null($s);
    }

    method test_first_or_default_array() {
        my $r := Rosella::Query::as_queryable([1, 2, 3, 4]).first_or_default.data;
        $!assert.equal($r, 1);
        my $s := Rosella::Query::as_queryable([]).first_or_default.data;
        $!assert.is_null($s);
    }

    method test_first_or_default_scalar() {
        $!status.unimplemented("tests for .first_or_default()");
    }

    # keys

    method test_keys_hash() {
        my @r := Rosella::Query::as_queryable(test_hash()).keys.data;
        $!assert.equal(+@r, 4);
    }

    method test_keys_array() {
        $!assert.throws({
            my $r := Rosella::Query::as_queryable([1, 2, 3, 4]).keys.data;
        });
    }

    method test_keys_scalar() {
        $!status.unimplemented("tests for .keys()");
    }
}
