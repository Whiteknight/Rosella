// Automatically generated test for Class Rosella.Dumper.DumpHandler.Array
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Dumper.DumpHandler.Array(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Dumper_DumpHandler_Array
{
    function can_dump()
    {
        self.status.verify("Test Rosella.Dumper.DumpHandler.Array.can_dump()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.can_dump(arg_0);
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
    var(Rosella.Test.test)(class Test_Rosella_Dumper_DumpHandler_Array, initialize_test:[named("initialize")]);
}
