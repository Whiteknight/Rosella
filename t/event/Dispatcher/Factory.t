// Automatically generated test for Class Rosella.Event.Dispatcher.Factory
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Event.Dispatcher.Factory(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Event_Dispatcher_Factory
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Event.Dispatcher.Factory();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event.Dispatcher.Factory);
    }

    function create()
    {
        self.status.verify("Test Rosella.Event.Dispatcher.Factory.create()");
        var obj = create_new();

        string arg_0 = "immediate";
        var result = obj.create(arg_0);
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Event.Dispatcher.Immediate);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event_Dispatcher_Factory);
}
