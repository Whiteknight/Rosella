class Test_Rosella_Container_Option_Initializer
{
    function execute()
    {
        var c = new Rosella.Container();
        int called = false;
        c.register("String", new Rosella.Container.Option.Initializer(function(i) { called = true; }));
        var obj = c.resolve("String");
        self.assert.is_true(called);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Option_Initializer);
}
