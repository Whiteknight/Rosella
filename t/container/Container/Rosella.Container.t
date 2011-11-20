class Test_Rosella_Container
{
    // Tests for Functions

    function default_container()
    {
        self.status.verify("Test Rosella.Container.default_container()");
        using Rosella.Container.default_container;

        var result = default_container();
        self.assert.instance_of(result, class Rosella.Container);
    }

    function set_default_container()
    {
        self.status.verify("Test Rosella.Container.set_default_container()");
        using Rosella.Container.set_default_container;
        using Rosella.Container.default_container;

        var arg_0 = "Test";
        set_default_container(arg_0);
        var result = default_container();
        self.assert.same(result, arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container);
}
