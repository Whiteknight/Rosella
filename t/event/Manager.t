function create_new()
{
    return new Rosella.Event.Manager();
}

class Test_Rosella_Event_Manager
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Event.Manager();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Event.Manager);
    }

    function register_event()
    {
        self.status.verify("Test Rosella.Event.Manager.register_event()");
        var obj = create_new();

        string arg_0 = "test";
        var arg_1 = new Rosella.Event();
        var result = obj.register_event(arg_0, arg_1);
    }

    function register_event_nonevent()
    {
        self.status.verify("Test .register_event() with non-event");
        var obj = create_new();

        string arg_0 = "test";
        string arg_1 = "foo";
        self.assert.throws(function() {
            var result = obj.register_event(arg_0, arg_1);
        });
    }

    function remove_event()
    {
        self.status.verify("Test Rosella.Event.Manager.remove_event()");
        var obj = create_new();

        var arg_0 = "test";
        var result = obj.remove_event(arg_0);
    }

    function get_event()
    {
        self.status.verify("Test Rosella.Event.Manager.get_event()");
        var obj = create_new();

        string arg_0 = "test";
        var result = obj.get_event(arg_0);
        self.assert.not_null(result);
    }

    function create_event()
    {
        self.status.verify("Test Rosella.Event.Manager.create_event()");
        var obj = create_new();

        var arg_0 = "test";
        var result = obj.create_event(arg_0);
        self.assert.not_null(result);
    }

    function count_events()
    {
        self.status.verify("Test Rosella.Event.Manager.count_events()");
        var obj = create_new();

        int result = obj.count_events();
        self.assert.equal(result, 0);
    }

    function get_pmc_keyed()
    {
        self.status.verify("Test Rosella.Event.Manager.get_pmc_keyed()");
        var obj = create_new();

        var arg_0 = "test";
        var result = obj[arg_0];
        self.assert.not_null(result);
    }

    function set_pmc_keyed()
    {
        self.status.verify("Test Rosella.Event.Manager.set_pmc_keyed()");
        var obj = create_new();

        var arg_0 = "test";
        var arg_1 = new Rosella.Event();
        obj[arg_0] = arg_1;
    }

    function elements()
    {
        self.status.verify("Test Rosella.Event.Manager.elements()");
        var obj = create_new();

        int result = elements(obj);
        self.assert.equal(result, 0);
    }

    function delete_keyed()
    {
        self.status.verify("Test Rosella.Event.Manager.delete_keyed()");
        var obj = create_new();

        var arg_0 = "test";
        var result = obj.delete_keyed(arg_0);
    }

    function exists_keyed()
    {
        self.status.verify("Test Rosella.Event.Manager.exists_keyed()");
        var obj = create_new();

        var arg_0 = "test";
        int result = obj.exists_keyed(arg_0);
        self.assert.equal(result, 0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event_Manager);
}
