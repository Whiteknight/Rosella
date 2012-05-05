// Automatically generated test for Class Rosella.Net.Http.Header
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Net.Http.Header(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Net_Http_Header
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Net.Http.Header();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Net.Http.Header);
    }

    function add_value()
    {
        self.status.verify("Test Rosella.Net.Http.Header.add_value()");
        var obj = create_new();

        string arg_0 = "foo";
        string arg_1 = "bar";
        obj.add_value(arg_0, arg_1);
    }

    function contains_value()
    {
        self.status.verify("Test Rosella.Net.Http.Header.contains_value()");
        var obj = create_new();

        string arg_0 = "foo";
        int result = obj.contains_value(arg_0);
        self.assert.is_false(result);
        obj.add_value(arg_0, "bar");
        result = obj.contains_value(arg_0);
        self.assert.is_true(result);
    }

    function remove_value()
    {
        self.status.verify("Test Rosella.Net.Http.Header.remove_value()");
        var obj = create_new();

        string arg_0 = "foo";

        self.assert.is_false(obj.contains_value(arg_0));

        obj.remove_value(arg_0);

        self.assert.is_false(obj.contains_value(arg_0));

        obj.add_value(arg_0, "bar");
        self.assert.is_true(obj.contains_value(arg_0));
    }

    function get_value()
    {
        self.status.verify("Test Rosella.Net.Http.Header.get_value()");
        var obj = create_new();

        string arg_0 = "foo";
        string result = obj.get_value(arg_0);
        self.assert.equal(result, "");
    }

    function clear()
    {
        self.status.verify("Test Rosella.Net.Http.Header.clear()");
        var obj = create_new();

        var result = obj.clear();
    }

    function get_header_text()
    {
        self.status.verify("Test Rosella.Net.Http.Header.get_header_text()");
        var obj = create_new();

        var result = obj.get_header_text();
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
    var(Rosella.Test.test)(class Test_Rosella_Net_Http_Header, initialize_test:[named("initialize")]);
}
