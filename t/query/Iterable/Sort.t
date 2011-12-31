// Automatically generated test for Class Rosella.Query.Iterable.Sort
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Sort(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Sort
{
    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Sort.next()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.next();
    }

    function has_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.Sort.has_more()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.has_more();
    }

    function reset()
    {
        self.status.verify("Test Rosella.Query.Iterable.Sort.reset()");
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
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Sort);
}
