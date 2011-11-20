class MyTestClass { }
class MyTestSubclass { }
class MyTestConstructorClass
{
    var a;
    function MyTestConstructorClass(var a) { self.a = a; }
}

class Test_Rosella_Container_Resolver_Factory
{
    function resolve_internal()
    {
        self.status.verify("Test Rosella.Container.Resolver.Factory.resolve_internal()");
        var c = new Rosella.Container();
        c.register(class MyTestClass,
            new Rosella.Container.Resolver.Factory(
                new Rosella.ObjectFactory(class MyTestSubclass),
                "create"
            )
        );
        var obj = c.resolve(class MyTestClass);
        self.assert.instance_of(obj, class MyTestSubclass);
    }

    function resolve_internal_args()
    {
        self.status.verify("Pass args to the factory's method");
        var c = new Rosella.Container();
        c.register(class MyTestConstructorClass,
            new Rosella.Container.Resolver.Factory(
                new Rosella.ObjectFactory(class MyTestConstructorClass),
                "create",
                new Rosella.Container.Argument.Instance(4)
            )
        );
        var obj = c.resolve(class MyTestConstructorClass);
        self.assert.equal(obj.*"a", 4);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Resolver_Factory);
}
