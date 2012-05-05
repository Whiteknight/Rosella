// Automatically generated test for NameSpace Rosella.Net.Uri
class Test_Rosella_Net_Uri
{
    function percent_encode_except()
    {
        self.status.verify("Test Rosella.Net.Uri.percent_encode_except()");
        self.status.unimplemented("TODO");
        using Rosella.Net.Uri.percent_encode_except;

        var arg_0 = null;
        var arg_1 = null;
        var result = percent_encode_except(arg_0, arg_1);
    }

    function percent_encode()
    {
        self.status.verify("Test Rosella.Net.Uri.percent_encode()");
        self.status.unimplemented("TODO");
        using Rosella.Net.Uri.percent_encode;

        var arg_0 = null;
        var result = percent_encode(arg_0);
    }

    function percent_encode_component()
    {
        self.status.verify("Test Rosella.Net.Uri.percent_encode_component()");
        self.status.unimplemented("TODO");
        using Rosella.Net.Uri.percent_encode_component;

        var arg_0 = null;
        var result = percent_encode_component(arg_0);
    }

    function default_uri_factory()
    {
        self.status.verify("Test Rosella.Net.Uri.default_uri_factory()");
        using Rosella.Net.Uri.default_uri_factory;
        var result = default_uri_factory();
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Net.Uri.Factory);
    }

    function get_uri()
    {
        self.status.verify("Test Rosella.Net.Uri.get_uri()");
        self.status.unimplemented("TODO");
        using Rosella.Net.Uri.get_uri;

        var arg_0 = null;
        var result = get_uri(arg_0);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Uri, initialize_test:[named("initialize")]);
}
