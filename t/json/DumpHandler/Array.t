// Automatically generated test for Class Rosella.Json.DumpHandler.Array
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Json.DumpHandler.Array;
}

class Test_Rosella_Json_DumpHandler_Array
{
    function can_dump()
    {
        self.status.verify("Test Rosella.Json.DumpHandler.Array.can_dump()");
        var obj = create_new();

        var arg_0 = [];
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
    var(Rosella.Test.test)(class Test_Rosella_Json_DumpHandler_Array, initialize_test:[named("initialize")]);
}
