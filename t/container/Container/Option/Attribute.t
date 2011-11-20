class MyTestClass { var a; }

class Test_Rosella_Container_Option_Attribute
{
    function execute()
    {
        self.status.verify("Test Rosella.Container.Option.Attribute.execute()");
        var c = new Rosella.Container();
        c.register(class MyTestClass, new Rosella.Container.Option.Attribute("a", "test"));
        var obj = c.resolve(class MyTestClass);
        self.assert.equal(obj.*"a", "test");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Option_Attribute);
}
