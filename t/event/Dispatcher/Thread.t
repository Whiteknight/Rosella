function create_new()
{
    return new Rosella.Event.Dispatcher.Thread();
}

class Test_Rosella_Event_Dispatcher_Thread
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Event.Dispatcher.Thread();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event.Dispatcher.Thread);
    }

    function dispatch()
    {
        self.status.verify("Test Rosella.Event.Dispatcher.Thread.dispatch()");
        self.status.unimplemented("We don't have threads yet");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.dispatch(arg_0, arg_1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event_Dispatcher_Thread);
}
