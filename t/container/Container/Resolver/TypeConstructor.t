class MyTestClass
{
    var a;
    var b;

    function MyTestClass(var a, var b)
    {
        self.a = a;
        self.b = b;
    }
}

class Test_Rosella_Container_Resolver_TypeConstructor
{
    function resolve_internal()
    {
        self.status.verify("Test Rosella.Container.Resolver.TypeConstructor.resolve_internal()");
        var c = new Rosella.Container();
        c.register(class MyTestClass,
            new Rosella.Container.Resolver.TypeConstructor(class MyTestClass, "MyTestClass",
                new Rosella.Container.Argument.Instance(4),
                new Rosella.Container.Argument.Instance(5)
            )
        );
        var obj = c.resolve(class MyTestClass);
        self.assert.equal(obj.*"a", 4);
        self.assert.equal(obj.*"b", 5);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Resolver_TypeConstructor);
}
