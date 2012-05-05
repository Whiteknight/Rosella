// Automatically generated test for Class Rosella.Net.Uri.File
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    var factory = new Rosella.Net.Uri.Factory();
    return factory.create_typed(class Rosella.Net.Uri.File, p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Uri_File
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Net.Uri.File("file", "://foo/bar/baz");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Net.Uri.File);
    }

    function host()
    {
        self.status.verify("Test Rosella.Net.Uri.File.host()");
        var obj = create_new("file://foo/bar/baz.fie");

        string result = obj.host();
        self.assert.equal(result, "foo");
    }

    function host_default()
    {
        self.status.verify("Test Rosella.Net.Uri.File.host() with default host");
        var obj = create_new("file:///bar/baz.fie");

        string result = obj.host();
        self.assert.equal(result, ".");
    }

    function path()
    {
        self.status.verify("Test Rosella.Net.Uri.File.path()");
        var obj = create_new("file://foo/bar/baz.fie");

        string result = obj.path();
        self.assert.equal(result, "bar/baz.fie");
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Uri_File, initialize_test:[named("initialize")]);
}
