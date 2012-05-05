// Automatically generated test for Class Rosella.Net.Uri.Factory
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.Uri.Factory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Uri_Factory
{
    function add_uri_type()
    {
        self.status.verify("Test Rosella.Net.Uri.Factory.add_uri_type()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.add_uri_type(arg_0, arg_1);
    }

    function create()
    {
        self.status.verify("Test Rosella.Net.Uri.Factory.create()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.create(arg_0);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/net.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Net_Uri_Factory, initialize_test:[named("initialize")]);
}
