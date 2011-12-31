// Automatically generated test for Class Rosella.Query.Iterable.TakeSkip
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.TakeSkip(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_TakeSkip
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.TakeSkip();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.TakeSkip);
    }


    function TakeSkip()
    {
        self.status.verify("Test Rosella.Query.Iterable.TakeSkip.TakeSkip()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var result = obj.TakeSkip(arg_0, arg_1, arg_2, arg_3);
    }

    function _skip()
    {
        self.status.verify("Test Rosella.Query.Iterable.TakeSkip._skip()");
        var obj = create_new();

        var result = obj._skip();
    }

    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.TakeSkip.next()");
        var obj = create_new();

        var result = obj.next();
    }

    function has_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.TakeSkip.has_more()");
        var obj = create_new();

        var result = obj.has_more();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_TakeSkip);
}
