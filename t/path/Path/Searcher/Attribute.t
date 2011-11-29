class Test::Rosella::Path::Searcher::Attribute {
    sub get_Rosella_Path_Searcher_Attribute() {
        return Rosella::construct(Rosella::Path::Searcher::Attribute);
    }

    method test_new() {
        my $obj := get_Rosella_Path_Searcher_Attribute();
        $!assert.not_null($obj);
        $!assert.instance_of($obj, Rosella::Path::Searcher::Attribute);
    }

    method method_can_search() {
        $!status.verify("default test for can_search");
        my $obj := get_Rosella_Path_Searcher_Attribute();
        my $result := $obj.can_search($obj);
    }

    method method_search() {
        $!status.verify("default test for search");
        $!status.unimplemented("TODO");
        my $obj := get_Rosella_Path_Searcher_Attribute();
        my $result := $obj.search($obj);
    }
}

Rosella::Test::test(Test::Rosella::Path::Searcher::Attribute);

INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file("rosella/path.pbc", "load");
}

