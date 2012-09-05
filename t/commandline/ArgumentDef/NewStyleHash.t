// Automatically generated test for Class Rosella.CommandLine.ArgumentDef.NewStyleHash
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.CommandLine.ArgumentDef.NewStyleHash(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_CommandLine_ArgumentDef_NewStyleHash
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.CommandLine.ArgumentDef.NewStyleHash();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.CommandLine.ArgumentDef.NewStyleHash);
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
    var(Rosella.Test.test)(class Test_Rosella_CommandLine_ArgumentDef_NewStyleHash, initialize_test:[named("initialize")]);
}
