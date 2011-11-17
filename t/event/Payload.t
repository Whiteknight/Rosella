class Test_Rosella_Event_Payload
{
    function test_new()
    {
        var obj = new Rosella.Event.Payload(null, "", null, null);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event.Payload);
    }

    function get_pmc_keyed()
    {
        var obj = new Rosella.Event.Payload(null, "", [], {"a" : 1, "b" : 2});

        string arg_0 = "b";
        var result = obj[arg_0];
        self.assert.equal(result, 2);
    }

    function get_pmc_keyed_int()
    {
        var obj = new Rosella.Event.Payload(null, "", ["a", "b", "c"], {});

        int arg_0 = 0;
        var result = obj[arg_0];
        self.assert.equal(result, "a");
    }

    function positional_payload()
    {
        var arg_0 = [1, 2, 3];
        var obj = new Rosella.Event.Payload(null, "", arg_0, {});
        var result = obj.positional_payload();
        self.assert.same(arg_0, result);
    }

    function named_payload()
    {
        var arg_0 = {"a" : 1, "b" : 2};
        var obj = new Rosella.Event.Payload(null, "", [], arg_0);
        var result = obj.named_payload();
        self.assert.same(arg_0, result);
    }

    function result()
    {
        self.status.unimplemented("TODO");
    }

    function set_result()
    {
        var obj = new Rosella.Event.Payload(null, "", [], {});
        obj.set_result("test");
        var result = obj.result();
        self.assert.equal(result, "test");
    }

    function subscriber_name()
    {
        var obj = new Rosella.Event.Payload(null, "", [], {});
        self.status.unimplemented("TODO");

        var result = obj.subscriber_name();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event_Payload);
}
