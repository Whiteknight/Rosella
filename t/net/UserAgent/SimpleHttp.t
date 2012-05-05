// Automatically generated test for Class Rosella.Net.UserAgent.SimpleHttp
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.UserAgent.SimpleHttp(p_args:[flat], n_args:[flat,named]);
}

// TODO: We're probably going to want to mock out sockets for this
class Test_Rosella_Net_UserAgent_SimpleHttp
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Net.UserAgent.SimpleHttp();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Net.UserAgent.SimpleHttp);
    }

    function supported_protocols()
    {
        self.status.verify("Test Rosella.Net.UserAgent.SimpleHttp.supported_protocols()");
        var obj = create_new();

        var result = obj.supported_protocols();
    }

    function get()
    {
        self.status.verify("Test Rosella.Net.UserAgent.SimpleHttp.get()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.get(arg_0);
    }

    function post()
    {
        self.status.verify("Test Rosella.Net.UserAgent.SimpleHttp.post()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.post(arg_0, arg_1);
    }

    function put()
    {
        self.status.verify("Test Rosella.Net.UserAgent.SimpleHttp.put()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.put(arg_0, arg_1);
    }

    function delete()
    {
        self.status.verify("Test Rosella.Net.UserAgent.SimpleHttp.delete()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.delete(arg_0);
    }

    function head()
    {
        self.status.verify("Test Rosella.Net.UserAgent.SimpleHttp.head()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.head(arg_0);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_UserAgent_SimpleHttp, initialize_test:[named("initialize")]);
}
