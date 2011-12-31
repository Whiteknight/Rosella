// Automatically generated test for Class Rosella.Query.Provider.Factory
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Provider.Factory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Provider_Factory
{
    function create()
    {
        self.status.verify("Test Rosella.Query.Provider.Factory.create()");
        var obj = create_new();

        var arg_0 = [];
        var result = obj.create(arg_0);
        self.assert.instance_of(result, class Rosella.Query.Provider.Array);

        arg_0 = {};
        result = obj.create(arg_0);
        self.assert.instance_of(result, class Rosella.Query.Provider.Hash);

        arg_0 = 7;
        result = obj.create(arg_0);
        self.assert.instance_of(result, class Rosella.Query.Provider.Scalar);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Provider_Factory);
}
