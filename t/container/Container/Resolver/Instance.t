class Test_Rosella_Container_Resolver_Instance
{
    function resolve_internal()
    {
        self.status.verify("Test Rosella.Container.Resolver.Instance.resolve_internal()");
        var c = new Rosella.Container();
        var arg_0 = "test";
        c.register("String", new Rosella.Container.Resolver.Instance(arg_0));
        var obj = c.resolve("String");
        self.assert.same(obj, arg_0);
    }

    function resolve_internal_implicit()
    {
        self.status.verify("Test Rosella.Container.Resolver.Instance.resolve_internal()");
        var c = new Rosella.Container();
        c.register("String", "test");
        var obj = c.resolve("String");
        self.assert.equal(obj, "test");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Resolver_Instance);
}
