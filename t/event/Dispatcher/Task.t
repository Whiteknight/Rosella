// Automatically generated test for Class Rosella.Event.Dispatcher.Task
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Event.Dispatcher.Task(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Event_Dispatcher_Task
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Event.Dispatcher.Task();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event.Dispatcher.Task);
    }

    function dispatch()
    {
        self.status.verify("Test Rosella.Event.Dispatcher.Task.dispatch()");
        var obj = create_new();

        var arg_0 = [];
        var arg_1 = function() { };
        var result = obj.dispatch(arg_0, arg_1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event_Dispatcher_Task);
}
