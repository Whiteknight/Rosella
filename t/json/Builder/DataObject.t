// Automatically generated test for Class Rosella.Json.Builder.DataObject
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Json.Builder.DataObject(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Json_Builder_DataObject
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Json.Builder.DataObject();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Json.Builder.DataObject);
    }

    function start()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.start()");
        var obj = create_new();

        obj.start();
    }

    function start_array()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.start_array()");
        var obj = create_new();

        string arg_0 = "foo";
        obj.start_array(arg_0);
    }

    function end_array()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.end_array()");
        var obj = create_new();

        obj.start_array("foo");
        obj.end_array();
    }

    function start_object()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.start_object()");
        var obj = create_new();

        string arg_0 = "foo";
        obj.start_object(arg_0);
    }

    function end_object()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.end_object()");
        var obj = create_new();

        obj.start_object("foo");
        obj.end_object();
    }

    function add_string()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.add_string()");
        var obj = create_new();

        string arg_0 = "foo";
        string arg_1 = "bar";
        obj.add_string(arg_0, arg_1);
    }

    function add_integer()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.add_integer()");
        var obj = create_new();

        string arg_0 = "foo";
        int arg_1 = 123;
        obj.add_integer(arg_0, arg_1);
    }

    function add_number()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.add_number()");
        var obj = create_new();

        string arg_0 = "foo";
        float arg_1 = 3.14;
        obj.add_number(arg_0, arg_1);
    }

    function add_boolean()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.add_boolean()");
        var obj = create_new();

        string arg_0 = "foo";
        int arg_1 = true;
        obj.add_boolean(arg_0, arg_1);
    }

    function add_null()
    {
        self.status.verify("Test Rosella.Json.Builder.DataObject.add_null()");
        var obj = create_new();

        string arg_0 = "foo";
        obj.add_null(arg_0);
    }
}

function initialize_test[anon](var context)
{
    // Set up the test suite here. Set options on the Suite, set up matchers
    // in the matcher factory, load prerequisites, and do other things.
    var(Rosella.load_bytecode_file)("rosella/json.pbc", "load");
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    using initialize_test;
    var(Rosella.Test.test)(class Test_Rosella_Json_Builder_DataObject, initialize_test:[named("initialize")]);
}
