// Automatically generated test for NameSpace Rosella.Net.Http
class Test_Rosella_Net_Http
{
    function formdata_encode()
    {
        self.status.verify("Test Rosella.Net.Http.formdata_encode()");
        self.status.unimplemented("TODO");
        using Rosella.Net.Http.formdata_encode;

        var arg_0 = null;
        var result = formdata_encode(arg_0);
    }

    function format_request_header()
    {
        self.status.verify("Test Rosella.Net.Http.format_request_header()");
        self.status.unimplemented("TODO");
        using Rosella.Net.Http.format_request_header;

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = format_request_header(arg_0, arg_1, arg_2);
    }

    function get_host_information()
    {
        self.status.verify("Test Rosella.Net.Http.get_host_information()");
        self.status.unimplemented("TODO");
        using Rosella.Net.Http.get_host_information;

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = get_host_information(arg_0, arg_1, arg_2);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Http, initialize_test:[named("initialize")]);
}
