INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(Test::Query);

class Test::Query {
    method as_queryable() {
        my %hash := {};
        my $q := Rosella::Query::as_queryable(%hash);
        $!assert.instance_of($q, Rosella::Query::Queryable);

        $q := Rosella::Query::as_queryable(%hash, 0);
        $!assert.instance_of($q, Rosella::Query::Queryable);

        $q := Rosella::Query::as_queryable(%hash, 1);
        $!assert.instance_of($q, Rosella::Query::Queryable::InPlace);
    }

    method is_hash() {
        my %hash := {};
        my @array := [];

        $!assert.is_false(Rosella::Query::is_hash(@array));
        $!assert.is_true(Rosella::Query::is_hash(%hash));
    }

    method is_array() {
        my %hash := {};
        my @array := [];

        $!assert.is_false(Rosella::Query::is_array(%hash));
        $!assert.is_true(Rosella::Query::is_array(@array));
    }
}
