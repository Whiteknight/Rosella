// Automatically generated test for NameSpace Rosella.Dumper
class Test_Rosella_Dumper
{
    function default_dumper()
    {
        self.status.verify("Test Rosella.Dumper.default_dumper()");
        using Rosella.Dumper.default_dumper;
        var result = default_dumper();
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Dumper);
    }

    function set_default_dumper()
    {
        self.status.verify("Test Rosella.Dumper.set_default_dumper()");
        using Rosella.Dumper.set_default_dumper;

        var arg_0 = "test";
        set_default_dumper(arg_0);

        using Rosella.Dumper.default_dumper;
        var result = default_dumper();
        self.assert.same(result, arg_0);
    }

    function dump()
    {
        self.status.verify("Test Rosella.Dumper.dump()");
        self.status.unimplemented("TODO");
        using Rosella.Dumper.dump;

        var arg_0 = null;
        var result = dump(arg_0);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Initialize the context, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/dumper.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Dumper, initialize_test:[named("initialize")]);
}
