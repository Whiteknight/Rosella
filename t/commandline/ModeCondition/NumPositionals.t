// Automatically generated test for Class Rosella.CommandLine.ModeCondition.NumPositionals
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.CommandLine.ModeCondition.NumPositionals(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_CommandLine_ModeCondition_NumPositionals
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.CommandLine.ModeCondition.NumPositionals(1, 2);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.ModeCondition.NumPositionals);
    }

    function is_satisfied()
    {
        self.status.verify("Test Rosella.CommandLine.ModeCondition.NumPositionals.is_satisfied()");
        self.status.unimplemented("Need testing strategy for ModeConditions");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.is_satisfied(arg_0);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/commandline.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_CommandLine_ModeCondition_NumPositionals, initialize_test:[named("initialize")]);
}
