INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test", "query");
}

# Tests that Queryable and Stream play nicely together and give similar results
# for operations.

Rosella::Test::test(Test::Queryable_Streams);

class Test::Queryable_Streams {
    sub arrays_equal($assert, @a, @b) {
        $assert.equal(pir::elements(@a), pir::elements(@b));
        my $i := 0;
        while $i <= pir::elements(@a) {
            $assert.equal(@a[$i], @b[$i]);
            $i++;
        }
    }

    method sort() {
        my $x := [5,4,6,3,7,2,8,1,9,10];
        my @y := Rosella::Query::as_queryable($x).sort().data();
        my @z := Rosella::Query::as_stream($x).sort().data();
        arrays_equal($!assert, @y, @z);
    }
}
