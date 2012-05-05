// Automatically generated test for Class Rosella.Net.Uri.Http
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    var factory = new Rosella.Net.Uri.Factory();
    return factory.create_typed(class Rosella.Net.Uri.Http, p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Uri_Http
{
    function path_query()
    {
        self.status.verify("Test Rosella.Net.Uri.Http.path_query()");
        var obj = create_new("http://www.parrot.org:80/path/to/page?foo=bar&baz=fie#lol");

        var result = obj.path_query();
    }

    function path()
    {
        self.status.verify("Test Rosella.Net.Uri.Http.path()");
        var obj = create_new("http://www.parrot.org:80/path/to/page?foo=bar&baz=fie#lol");

        string result = obj.path();
        self.assert.equal(result, "path/to/page");
    }

    function query()
    {
        self.status.verify("Test Rosella.Net.Uri.Http.query()");
        var obj = create_new("http://www.parrot.org:80/path/to/page?foo=bar&baz=fie#lol");

        string result = obj.query();
        self.assert.equal(result, "foo=bar&baz=fie");
    }

    function fragment()
    {
        self.status.verify("Test Rosella.Net.Uri.Http.fragment()");
        var obj = create_new("http://www.parrot.org:80/path/to/page?foo=bar&baz=fie#lol");

        string result = obj.fragment();
        self.assert.equal(result, "lol");
    }

    function host()
    {
        self.status.verify("Test Rosella.Net.Uri.Http.host()");
        var obj = create_new("http://www.parrot.org:80/path/to/page?foo=bar&baz=fie#lol");

        string result = obj.host();
        self.assert.equal(result, "www.parrot.org");
    }

    function authority()
    {
        self.status.verify("Test Rosella.Net.Uri.Http.authority()");
        var obj = create_new("http://www.parrot.org:80/path/to/page?foo=bar&baz=fie#lol");

        string result = obj.authority();
        self.assert.equal(result, "www.parrot.org");
    }

    function port()
    {
        self.status.verify("Test Rosella.Net.Uri.Http.authority()");
        var obj = create_new("http://www.parrot.org:80/path/to/page?foo=bar&baz=fie#lol");

        int result = obj.port();
        self.assert.equal(result, 80);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Uri_Http, initialize_test:[named("initialize")]);
}
