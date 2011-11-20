function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Container.Resolver.FactoryMethod(p_args:[flat], n_args:[flat,named]);
}

function get_container()
{
    return new Rosella.Container();
}

class Test_Rosella_Container_Resolver_FactoryMethod
{
    function resolve()
    {
        self.status.verify("Use a FactoryMethod in a registration");
        var c = get_container();
        c.register("String", create_new(function() { return "test string"; }));
        var result = c.resolve("String");
        self.assert.equal(result, "test string");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Resolver_FactoryMethod);
}
