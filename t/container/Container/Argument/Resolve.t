class Test_Rosella_Container_Argument_Resolve
{
    function get_value()
    {
        self.status.verify("Test Rosella.Container.Argument.Resolve.get_value()");
        var c = new Rosella.Container();
        c.register("String", "foo");
        var obj = new Rosella.Container.Argument.Resolve("String");
        var result = obj.get_value(c);
        self.assert.equal(result, "foo");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Argument_Resolve);
}
