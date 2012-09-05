// Automatically generated test for NameSpace Rosella.CommandLine.ArgumentDef
class Test_Rosella_CommandLine_ArgumentDef
{
    function get_argument_definition()
    {
        self.status.verify("Test Rosella.CommandLine.ArgumentDef.get_argument_definition()");
        using Rosella.CommandLine.ArgumentDef.get_argument_definition;

        var arg_0 = {};
        var result = get_argument_definition(arg_0);
        self.assert.instance_of(result, class Rosella.CommandLine.ArgumentDef.NewStyleHash);

        arg_0 = [];
        result = get_argument_definition(arg_0);
        self.assert.instance_of(result, class Rosella.CommandLine.ArgumentDef.OldStyleArray);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Initialize the context, set up matchers
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
