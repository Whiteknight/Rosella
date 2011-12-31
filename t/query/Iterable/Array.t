// Automatically generated test for Class Rosella.Query.Iterable.Array
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Array(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Array
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.Array();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.Array);
    }


    function Array()
    {
        self.status.verify("Test Rosella.Query.Iterable.Array.Array()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.Array(arg_0);
    }

    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Array.next()");
        var obj = create_new();

        var result = obj.next();
    }

    function next_and_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.Array.next_and_more()");
        var obj = create_new();

        var result = obj.next_and_more();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Array);
}
