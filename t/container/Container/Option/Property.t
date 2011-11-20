class MyTestClass { }

class Test_Rosella_Container_Option_Property
{
    function test_property()
    {
        self.status.verify("Test Rosella.Container.Option.Property.execute()");
        var c = new Rosella.Container();
        c.register(class MyTestClass, new Rosella.Container.Option.Property("test", "foo"));
        var obj = c.resolve(class MyTestClass);
        var prop_val;
        ${ getprop prop_val, "test", obj };
        self.assert.equal(prop_val, "foo");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Option_Property);
}
