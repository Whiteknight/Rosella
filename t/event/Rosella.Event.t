// Automatically generated test for NameSpace Rosella.Event
class Test_Rosella_Event
{
    // Tests for Functions

    function default_subscriber_factory()
    {
        self.status.verify("Test Rosella.Event.default_subscriber_factory()");
        using Rosella.Event.default_subscriber_factory;

        var result = default_subscriber_factory();
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Event.Subscriber.Factory);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/event.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Event);
}
