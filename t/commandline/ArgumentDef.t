// Automatically generated test for Class Rosella.CommandLine.ArgumentDef
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.CommandLine.ArgumentDef.NewStyleHash(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_CommandLine_ArgumentDef
{
    function set_definitions()
    {
        self.status.verify("Test Rosella.CommandLine.ArgumentDef.set_definitions()");
        var obj = create_new();

        var arg_0 = {};
        var result = obj.set_definitions(arg_0);
    }

    function get_positional_aliases()
    {
        self.status.verify("Test Rosella.CommandLine.ArgumentDef.get_positional_aliases()");
        var obj = create_new();

        var result = obj.get_positional_aliases();
        self.assert.equal(elements(result), 0);
    }

    function get_description()
    {
        self.status.verify("Test Rosella.CommandLine.ArgumentDef.get_description()");
        self.status.unimplemented("Need tests for description generation");
        var obj = create_new();

        var result = obj.get_description();
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
    var(Rosella.Test.test)(class Test_Rosella_CommandLine_ArgumentDef, initialize_test:[named("initialize")]);
}
