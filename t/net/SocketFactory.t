// Automatically generated test for Class Rosella.Net.SocketFactory
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.SocketFactory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_SocketFactory
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Net.SocketFactory("ipv4", "stream", "tcp", "");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Net.SocketFactory);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_SocketFactory, initialize_test:[named("initialize")]);
}
