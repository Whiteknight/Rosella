class Test_Rosella_Container_Argument_Instance
{
    function get_value()
    {
        self.status.verify("Test Rosella.Container.Argument.Instance.get_value()");
        var obj = new Rosella.Container.Argument.Instance("foo");
        var result = obj.get_value(null);
        self.assert.equal(result, "foo");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Argument_Instance);
}
