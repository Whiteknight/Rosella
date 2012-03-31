// Automatically generated test for Class Rosella.Dumper.DumpHandler
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Dumper.DumpHandler(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Dumper_DumpHandler
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Dumper.DumpHandler();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Dumper.DumpHandler);
    }

    function can_dump()
    {
        self.status.verify("Test Rosella.Dumper.DumpHandler.can_dump()");
        var obj = create_new();

        var arg_0 = null;
        int result = obj.can_dump(arg_0);
        self.assert.is_true(result);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/dumper.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Dumper_DumpHandler, initialize_test:[named("initialize")]);
}
