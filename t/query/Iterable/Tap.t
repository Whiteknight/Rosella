// Automatically generated test for Class Rosella.Query.Iterable.Tap
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Tap(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Tap
{
    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Tap.next()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.next();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Tap);
}
