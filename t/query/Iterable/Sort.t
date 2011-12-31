// Automatically generated test for Class Rosella.Query.Iterable.Sort
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Sort(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Sort
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.Sort();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.Sort);
    }


    function Sort()
    {
        self.status.verify("Test Rosella.Query.Iterable.Sort.Sort()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.Sort(arg_0, arg_1, arg_2);
    }

    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Sort.next()");
        var obj = create_new();

        var result = obj.next();
    }

    function has_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.Sort.has_more()");
        var obj = create_new();

        var result = obj.has_more();
    }

    function reset()
    {
        self.status.verify("Test Rosella.Query.Iterable.Sort.reset()");
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
