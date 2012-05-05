// Automatically generated test for Class Rosella.Net.Protocol.Http
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.Protocol.Http(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Protocol_Http
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Net.Protocol.Http();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Net.Protocol.Http);
    }

    function protocol_name()
    {
        self.status.verify("Test Rosella.Net.Protocol.Http.protocol_name()");
        var obj = create_new();

        string result = obj.protocol_name();
        self.assert.equal(result, "http");
    }

    function prepare_request()
    {
        self.status.verify("Test Rosella.Net.Protocol.Http.prepare_request()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.prepare_request(arg_0, arg_1);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Protocol_Http, initialize_test:[named("initialize")]);
}
