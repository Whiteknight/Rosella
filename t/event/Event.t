function create_new()
{
    return new Rosella.Event();
}

class Test_Rosella_Event
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Event();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event);
    }

    function subscribe()
    {
        self.status.verify("Test Rosella.Event.subscribe()");
        var obj = create_new();

        string arg_0 = "test";
        var arg_1 = null;
        string arg_2 = "immediate";
        var result = obj.subscribe(arg_0, arg_1, arg_2);
    }

    function unsubscribe()
    {
        self.status.verify("Test Rosella.Event.unsubscribe()");
        var obj = create_new();

        var arg_0 = "test";
        var result = obj.unsubscribe(arg_0);
    }

    function get_payload()
    {
        self.status.verify("Test Rosella.Event.get_payload()");
        var obj = create_new();
        var result = obj.get_payload("", null, null);
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Event.Payload);
    }

    function publish()
    {
        self.status.verify("Test Rosella.Event.publish()");
        self.status.unimplemented("Need many tests for publish");
        var obj = create_new();

        obj.publish();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event);
}
