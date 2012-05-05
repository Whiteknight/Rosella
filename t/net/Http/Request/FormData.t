// Automatically generated test for Class Rosella.Net.Http.Request.FormData
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.Http.Request.FormData(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Http_Request_FormData
{
    function field_name()
    {
        self.status.verify("Test Rosella.Net.Http.Request.FormData.field_name()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.field_name();
    }

    function get_multipart_content_string()
    {
        self.status.verify("Test Rosella.Net.Http.Request.FormData.get_multipart_content_string()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.get_multipart_content_string();
    }

    function get_post_content_string()
    {
        self.status.verify("Test Rosella.Net.Http.Request.FormData.get_post_content_string()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.get_post_content_string();
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Http_Request_FormData, initialize_test:[named("initialize")]);
}
