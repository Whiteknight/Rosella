// Automatically generated test for Class Rosella.Json.DumpHandler.Float
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Json.DumpHandler.Float;
}

class Test_Rosella_Json_DumpHandler_Float
{
    function can_dump()
    {
        self.status.verify("Test Rosella.Json.DumpHandler.Float.can_dump()");
        var obj = create_new();

        var arg_0 = 3.14;
        int result = obj.can_dump(arg_0);
        self.assert.is_true(result);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/json.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Json_DumpHandler_Float, initialize_test:[named("initialize")]);
}
