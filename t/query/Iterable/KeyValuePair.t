// Automatically generated test for Class Rosella.Query.Iterable.KeyValuePair
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.KeyValuePair(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_KeyValuePair
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.KeyValuePair();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.KeyValuePair);
    }


    function KeyValuePair()
    {
        self.status.verify("Test Rosella.Query.Iterable.KeyValuePair.KeyValuePair()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.KeyValuePair(arg_0, arg_1);
    }

    function key()
    {
        self.status.verify("Test Rosella.Query.Iterable.KeyValuePair.key()");
        var obj = create_new();

        var result = obj.key();
    }

    function value()
    {
        self.status.verify("Test Rosella.Query.Iterable.KeyValuePair.value()");
        var obj = create_new();

        var result = obj.value();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_KeyValuePair);
}
