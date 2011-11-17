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

    function get_pmc_keyed()
    {
        self.status.verify("Test Rosella.Event.get_pmc_keyed()");
        var obj = create_new();
        obj.prepare_to_publish([], {"a" : 1, "b" : 2});

        string arg_0 = "b";
        var result = obj[arg_0];
        self.assert.equal(result, 2);
    }

    function get_pmc_keyed_int()
    {
        self.status.verify("Test Rosella.Event.get_pmc_keyed_int()");
        var obj = create_new();
        obj.prepare_to_publish(["a", "b", "c"], {});

        int arg_0 = 0;
        var result = obj[arg_0];
        self.assert.equal(result, "a");
    }

    function positional_payload()
    {
        self.status.verify("Test Rosella.Event.positional_payload()");
        var obj = create_new();

        var arg_0 = [1, 2, 3];
        obj.prepare_to_publish(arg_0, {});
        var result = obj.positional_payload();
        self.assert.same(arg_0, result);
    }

    function named_payload()
    {
        self.status.verify("Test Rosella.Event.named_payload()");
        var obj = create_new();

        var arg_0 = {"a" : 1, "b" : 2};
        obj.prepare_to_publish([], arg_0);
        var result = obj.named_payload();
        self.assert.same(arg_0, result);
    }

    function prepare_to_publish()
    {
        self.status.verify("Test Rosella.Event.prepare_to_publish()");
        var obj = create_new();

        var arg_0 = [];
        var arg_1 = {};
        obj.prepare_to_publish(arg_0, arg_1);
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
