// Automatically generated test for Class Rosella.Query.Iterable.Factory
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Factory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Factory
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.Factory);
    }


    function Factory()
    {
        self.status.verify("Test Rosella.Query.Iterable.Factory.Factory()");
        var obj = create_new();

        var result = obj.Factory();
    }

    function get_default_provider()
    {
        self.status.verify("Test Rosella.Query.Iterable.Factory.get_default_provider()");
        var obj = create_new();

        var result = obj.get_default_provider();
    }

    function get_role_map()
    {
        self.status.verify("Test Rosella.Query.Iterable.Factory.get_role_map()");
        var obj = create_new();

        var result = obj.get_role_map();
    }

    function get_type_map()
    {
        self.status.verify("Test Rosella.Query.Iterable.Factory.get_type_map()");
        var obj = create_new();

        var result = obj.get_type_map();
    }

    function create()
    {
        self.status.verify("Test Rosella.Query.Iterable.Factory.create()");
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
