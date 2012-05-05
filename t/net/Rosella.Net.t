// Automatically generated test for NameSpace Rosella.Net
class Test_Rosella_Net
{
    function default_protocol_factory()
    {
        self.status.verify("Test Rosella.Net.default_protocol_factory()");
        using Rosella.Net.default_protocol_factory;
        var result = default_protocol_factory();
        self.assert.instance_of(result, class Rosella.Net.Protocol.Factory);
    }

    function get_protocol()
    {
        self.status.verify("Test Rosella.Net.get_protocol()");
        self.status.unimplemented("TODO");
        using Rosella.Net.get_protocol;

        string arg_0 = "http";
        var result = get_protocol(arg_0);
        self.assert.instane_of(result, class Rosella.Net.Protocol.Http);
    }

    function tcp_socket_factory_ipv4()
    {
        self.status.verify("Test Rosella.Net.tcp_socket_factory_ipv4()");
        using Rosella.Net.tcp_socket_factory_ipv4;
        var result = tcp_socket_factory_ipv4();
        self.assert.not_null(result);
    }

    function tcp_socket_factory_ipv6()
    {
        self.status.verify("Test Rosella.Net.tcp_socket_factory_ipv6()");
        using Rosella.Net.tcp_socket_factory_ipv6;
        var result = tcp_socket_factory_ipv6();
        self.assert.not_null(result);
    }

    function default_mime_encoder()
    {
        self.status.verify("Test Rosella.Net.default_mime_encoder()");
        using Rosella.Net.default_mime_encoder;
        var result = default_mime_encoder();
        self.assert.not_null(result);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Initialize the context, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/net.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Net, initialize_test:[named("initialize")]);
}
