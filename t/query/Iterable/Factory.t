// Automatically generated test for Class Rosella.Query.Iterable.Factory
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Factory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Factory
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.Factory);
    }

    function create()
    {
        self.status.verify("Test Rosella.Query.Iterable.Factory.create()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.create(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Factory);
}
