function create_new()
{
    return new Rosella.Event.Subscriber.Factory();
}

class Test_Rosella_Event_Subscriber_Factory
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Event.Subscriber.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event.Subscriber.Factory);
    }

    function create()
    {
        self.status.verify("Test Rosella.Event.Subscriber.Factory.create()");
        var obj = create_new();

        var arg_0 = function() { };
        string arg_1 = "immediate";
        var result = obj.create(arg_0, arg_1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event_Subscriber_Factory);
}
