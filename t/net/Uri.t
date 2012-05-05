// Automatically generated test for Class Rosella.Net.Uri
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.Uri(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Uri
{
    function uri()
    {
        self.status.verify("Test Rosella.Net.Uri.uri()");
        var obj = create_new("http", "//www.parrot.org");

        string result = obj.uri();
        self.assert.equal(result, "//www.parrot.org");
    }

    function protocol()
    {
        self.status.verify("Test Rosella.Net.Uri.protocol()");
        var obj = create_new("http", "//www.parrot.org");

        string result = obj.protocol();
        self.assert.equal(result, "http");
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Uri, initialize_test:[named("initialize")]);
}
