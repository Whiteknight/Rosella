// Automatically generated test for Class Rosella.Query.Iterable.Source
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Source(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Source
{
    function has_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.Source.has_more()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.has_more();
    }

    function on_data()
    {
        self.status.verify("Test Rosella.Query.Iterable.Source.on_data()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.on_data(arg_0);
    }

    function on_iterator()
    {
        self.status.verify("Test Rosella.Query.Iterable.Source.on_iterator()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.on_iterator(arg_0);
    }

    function reset()
    {
        self.status.verify("Test Rosella.Query.Iterable.Source.reset()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.reset();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Source);
}
