class Test::Rosella::Query::Stream {
    sub get_Rosella_Query_Stream($d) {
        return Rosella::construct(Rosella::Query::Stream, $d);
    }

    method test_new() {
        my $obj := get_Rosella_Query_Stream([]);
        $!assert.not_null($obj);
        $!assert.instance_of($obj, Rosella::Query::Stream);
    }

    method method_data() {
        $!status.verify("default test for data");
        my $obj := get_Rosella_Query_Stream([1, 2, 3, 4]);
        my @result := $obj.data();
        $!assert.equal(+@result, 4);
        $!assert.equal(@result[0], 1);
        $!assert.equal(@result[1], 2);
        $!assert.equal(@result[2], 3);
        $!assert.equal(@result[3], 4);
    }

    method method_execute() {
        $!status.verify("default test for execute");
        my $count := 0;
        my $obj := get_Rosella_Query_Stream([5, 6, 7, 8]).foreach(-> $i { $count++; });
        $obj.execute();
        $!assert.equal($count, 4);
    }

    method method_on_iterator() {
        $!status.verify("default test for on_iterator");
        my $obj := get_Rosella_Query_Stream([1, 2, 3]);
        $obj.on_iterator(-> $i { $!assert.instance_of($i, "ArrayIterator"); });
    }

    method method_on_data() {
        $!status.verify("default test for on_data");
        my $obj := get_Rosella_Query_Stream([1, 2, 3, 4]);
        my $result := $obj.on_data(-> $i {
            $!assert.equal(+$i, 4);
        });
    }

    method method_has_more() {
        $!status.verify("default test for has_more");
        my $obj := get_Rosella_Query_Stream([]);
        my $result := $obj.has_more();
        $!assert.is_false($result);

        $obj := get_Rosella_Query_Stream([1, 2, 3]);
        $result := $obj.has_more();
        $!assert.is_true($result);
    }

    method method_next() {
        $!status.verify("default test for next");
        my $obj := get_Rosella_Query_Stream([1, 2, 3]);
        my $result := $obj.next();
        $!assert.equal($result, 1);
        $result := $obj.next();
        $!assert.equal($result, 2);
        $result := $obj.next();
        $!assert.equal($result, 3);
        $!assert.throws({
            $result := $obj.next();
        });
    }

    method method_count() {
        $!status.verify("default test for count");
        my $obj := get_Rosella_Query_Stream([5, 6, 7, 8]);
        my $result := $obj.count();
        $!assert.equal($result, 4);
    }

    method method_any() {
        $!status.verify("default test for any");
        my $obj := get_Rosella_Query_Stream([]);
        my $result := $obj.any();
        $!assert.is_false($result);

        $obj := get_Rosella_Query_Stream([1, 3, 4]);
        $result := $obj.any();
        $!assert.is_true($result);

        $obj := get_Rosella_Query_Stream([1, 3, 4]);
        $result := $obj.any(-> $i { $i == 3 });
        $!assert.is_true($result);

        $obj := get_Rosella_Query_Stream([1, 3, 4]);
        $result := $obj.any(-> $i { $i == 2 });
        $!assert.is_false($result);
    }

    method method_foreach() {
        $!status.verify("default test for foreach");
        my $sum := 0;
        my $obj := get_Rosella_Query_Stream([1, 2, 4, 8]);
        #my $result := $obj.foreach(-> $i { $sum += $i }).execute();
        #$!assert.equal($result, 15);
    }

    method method_tap() {
        $!status.unimplemented("Double-check tap semantics, and find a way to test it.");
        $!status.verify("default test for tap");
        my $obj := get_Rosella_Query_Stream([1, 2, 4, 8]);
        my $result := $obj.tap();
    }

    method method_map() {
        $!status.verify("default test for map");
        my $obj := get_Rosella_Query_Stream([1, 2, 3]);
        my @result := $obj.map(-> $i { $i * 3 }).data();
        $!assert.equal(@result[0], 3);
        $!assert.equal(@result[1], 6);
        $!assert.equal(@result[2], 9);
    }

    method method_filter() {
        $!status.verify("default test for filter");
        my $obj := get_Rosella_Query_Stream([1, 2, 3, 4]);
        my @result := $obj.filter(-> $i { $i % 2 == 0 }).data();
        $!assert.equal(+@result, 2);
        $!assert.equal(@result[0], 2);
        $!assert.equal(@result[1], 4);
    }

    method method_fold() {
        $!status.verify("default test for fold");
        my $obj := get_Rosella_Query_Stream([1, 2, 4, 8]);
        my $result := $obj.fold(-> $s, $i { $s + $i }, 0).next();
        $!assert.equal($result, 15);
    }

    method method_sort() {
        $!status.verify("default test for sort");
        my $obj := get_Rosella_Query_Stream([4, 2, 1, 3]);
        my @result := $obj.sort(-> $a, $b { +($a - $b) }).data();
        $!assert.equal(+@result, 4);
        $!assert.equal(@result[0], 1);
        $!assert.equal(@result[1], 2);
        $!assert.equal(@result[2], 3);
        $!assert.equal(@result[3], 4);
    }

    method method_take() {
        $!status.verify("default test for take");
        my $obj := get_Rosella_Query_Stream([1, 2, 3, 4]);
        my @result := $obj.take(2).data();
        $!assert.equal(+@result, 2);
        $!assert.equal(@result[0], 1);
        $!assert.equal(@result[1], 2);
    }

    method method_skip() {
        $!status.verify("default test for skip");
        my $obj := get_Rosella_Query_Stream([1, 2, 3, 4]);
        my @result := $obj.skip(2).data();
        $!assert.equal(+@result, 2);
        $!assert.equal(@result[0], 3);
        $!assert.equal(@result[1], 4);
    }

    method method_flatten() {
        $!status.verify("default test for flatten");
        $!status.todo("Figure out why this is out of order");
        my $obj := get_Rosella_Query_Stream([[1], [[2], 3], 4]);
        my @result := $obj.flatten().data();
        $!assert.equal(+@result, 4);
        $!assert.equal(@result[0], 1);
        $!assert.equal(@result[1], 2);
        $!assert.equal(@result[2], 3);
        $!assert.equal(@result[3], 4);
    }

    method method_append() {
        $!status.verify("default test for append");
        my $obj := get_Rosella_Query_Stream([1, 2]);
        my @result := $obj.append([3, 4]).data();
        $!assert.equal(+@result, 4);
        $!assert.equal(@result[0], 1);
        $!assert.equal(@result[1], 2);
        $!assert.equal(@result[2], 3);
        $!assert.equal(@result[3], 4);
    }

    method method_project() {
        $!status.verify("default test for project");
        my $obj := get_Rosella_Query_Stream([5, 7]);
        my @result := $obj.project(-> $i { [$i - 4, $i - 3] }).data();
        $!assert.equal(+@result, 4);
        $!assert.equal(@result[0], 1);
        $!assert.equal(@result[1], 2);
        $!assert.equal(@result[2], 3);
        $!assert.equal(@result[3], 4);
    }

    method method_get_iter() {
        $!status.unimplemented("Find a way to test get_iter");
        $!status.verify("default test for get_iter");
        my $obj := get_Rosella_Query_Stream();
        my $result := $obj.get_iter();
    }
}

Rosella::Test::test(Test::Rosella::Query::Stream);

INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file("rosella/query.pbc", "load");
}

