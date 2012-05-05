// Automatically generated test for Class Rosella.Net.MimeBase64
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.MimeBase64(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_MimeBase64
{
    function encode()
    {
        self.status.verify("Test Rosella.Net.MimeBase64.encode()");
        var obj = create_new();

        var arg_0 = "This is a test";
        string result = obj.encode(arg_0);
        self.assert.equal(result, "VGhpcyBpcyBhIHRlc3Q=");
    }

    function decode()
    {
        self.status.verify("Test Rosella.Net.MimeBase64.decode()");
        var obj = create_new();

        string arg_0 = "VGhpcyBpcyBhIHRlc3Q=";
        string t = "This is a test";
        string result = obj.decode(arg_0);
        self.assert.str_equal(result, t);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_MimeBase64, initialize_test:[named("initialize")]);
}
