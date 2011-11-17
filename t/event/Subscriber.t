// Automatically generated test for Class Rosella.Event.Subscriber
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Event.Subscriber(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Event_Subscriber
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Event.Subscriber(null, null);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event.Subscriber);
    }

    function execute()
    {
        self.status.verify("Test Rosella.Event.Subscriber.execute()");
        int called = 0;
        var obj = create_new(function(e) { called = 1; }, new Rosella.Event.Dispatcher.Immediate());

        var arg_0 = null;
        obj.execute(arg_0);
        self.assert.equal(called, 1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event_Subscriber);
}
