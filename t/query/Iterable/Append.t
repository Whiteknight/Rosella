// Automatically generated test for Class Rosella.Query.Iterable.Append
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Append(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Append
{
    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Append.next()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.next();
    }

    function has_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.Append.has_more()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.has_more();
    }

    function append()
    {
        self.status.verify("Test Rosella.Query.Iterable.Append.append()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.append(arg_0);
    }

    function reset()
    {
        self.status.verify("Test Rosella.Query.Iterable.Append.reset()");
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
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Append);
}
