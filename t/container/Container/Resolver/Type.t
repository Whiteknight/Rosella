class Test_Rosella_Container_Resolver_Type
{
    function resolve_internal()
    {
        self.status.verify("Test Rosella.Container.Resolver.Type.resolve_internal()");
        var c = new Rosella.Container();
        c.register("String", new Rosella.Container.Resolver.Type("String"));
        var obj = c.resolve("String");
        self.assert.instance_of(obj, "String");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Resolver_Type);
}
