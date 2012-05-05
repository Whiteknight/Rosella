// Automatically generated test for Class Rosella.Net.Http.Request
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.Http.Request(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Http_Request
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Net.Http.Request();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Net.Http.Request);
    }

    function get_method()
    {
        self.status.verify("Test Rosella.Net.Http.Request.get_method()");
        var obj = create_new();

        string result = obj.get_method();
        self.assert.equal(result, "GET");
    }

    function set_method()
    {
        self.status.verify("Test Rosella.Net.Http.Request.set_method()");
        var obj = create_new();

        self.assert.equal(obj.get_method(), "GET");
        string arg_0 = "POST";
        obj.set_method(arg_0);
        self.assert.equal(obj.get_method(), "POST");
    }

    function header()
    {
        self.status.verify("Test Rosella.Net.Http.Request.header()");
        var obj = create_new();

        var result = obj.header();
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Net.Http.Header);
    }

    function get_content()
    {
        self.status.verify("Test Rosella.Net.Http.Request.get_content()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.get_content();
    }

    function set_content()
    {
        self.status.verify("Test Rosella.Net.Http.Request.set_content()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.set_content(arg_0);
    }

    function add_form_fields()
    {
        self.status.verify("Test Rosella.Net.Http.Request.add_form_fields()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.add_form_fields(arg_0);
    }

    function add_form_field()
    {
        self.status.verify("Test Rosella.Net.Http.Request.add_form_field()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.add_form_field(arg_0, arg_1);
    }

    function add_form_field_file()
    {
        self.status.verify("Test Rosella.Net.Http.Request.add_form_field_file()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.add_form_field_file(arg_0, arg_1);
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Http_Request, initialize_test:[named("initialize")]);
}
