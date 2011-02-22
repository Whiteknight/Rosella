INIT {
    pir::load_bytecode("rosella/xunit.pbc");
    pir::load_bytecode("rosella/query.pbc");
}

Rosella::Testcase::test(QueryTest);

class QueryTest is Rosella::Testcase {
    method test_map_hash() {
        my %data := {};
        %data{"foo"} := 1;
        %data{"bar"} := 2;
        %data{"baz"} := 3;
        %data{"fie"} := 4;
        my %new_data := Rosella::Query::map(%data, sub($item) { return "($item)"; });
        Assert::equal(%new_data{"foo"}, "(1)");
        Assert::equal(%new_data{"bar"}, "(2)");
        Assert::equal(%new_data{"baz"}, "(3)");
        Assert::equal(%new_data{"fie"}, "(4)");
    }

    method test_map_array() {
        my @data := <foo bar baz fie>;
        my @new_data := Rosella::Query::map(@data, sub($item) { return "($item)"; });
        Assert::equal(pir::elements(@new_data), 4);
        Assert::equal(@new_data[0], "(foo)");
        Assert::equal(@new_data[1], "(bar)");
        Assert::equal(@new_data[2], "(baz)");
        Assert::equal(@new_data[3], "(fie)");
    }
}
