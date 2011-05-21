INIT {
    pir::load_bytecode("rosella/test.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Test::test(Test::Query::Queryable::InPlace);

class Test::Query::Queryable::InPlace {
    method get_queryable() {
        my @data := <1, 2, 3, 4>;
        my $q := Rosella::construct(Rosella.Query.Queryable, @data);
        my $new_q := $q.as_queryable(@data);
        $!assert.same($q, $new_q);
    }

}
