function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Decorate.Factory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Decorate_Factory
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        self.status.unimplemented("TODO");
        var obj = new Rosella.Decorate.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Decorate.Factory);
    }

    function create()
    {
        self.status.verify("Test Rosella.Decorate.Factory.create()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = 1;
        var result = obj.create(arg_0);
        self.assert.instance_of(result, class Rosella.Decorate.Decorator);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/decorate.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Decorate_Factory);
}
