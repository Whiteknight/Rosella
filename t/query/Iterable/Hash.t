// Automatically generated test for Class Rosella.Query.Iterable.Hash
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Hash(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Hash
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.Hash();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.Hash);
    }


    function Hash()
    {
        self.status.verify("Test Rosella.Query.Iterable.Hash.Hash()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.Hash(arg_0);
    }

    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Hash.next()");
        var obj = create_new();

        var result = obj.next();
    }

    function next_and_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.Hash.next_and_more()");
        var obj = create_new();

        var result = obj.next_and_more();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Hash);
}
