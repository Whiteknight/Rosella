function create_new()
{
    return new Rosella.Dumper();
}

class Test_Rosella_Dumper
{
    function test_new()
    {
        var d = new Rosella.Dumper();
        self.assert.not_null(d);
    }

    function dump_string()
    {
        var d = create_new();
        string s = d.dump("test");
        self.assert.not_equal(indexof(s, "test"), -1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/dumper.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Dumper);
}
