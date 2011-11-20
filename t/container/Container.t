class MyTestClass
{
    var a;
    var b;
    function MyTestClass(var a, var b) { self.a = a; self.b = b; }
    function a() { return self.a; }
    function b() { return self.b; }
}

function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Container(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Container
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Container();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Container);
    }

    function register()
    {
        self.status.verify("Test Rosella.Container.register()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.register(arg_0);
    }

    function unregister()
    {
        self.status.verify("Test Rosella.Container.unregister()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.unregister(arg_0);
    }

    function unregister_all()
    {
        self.status.verify("Test Rosella.Container.unregister_all()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.unregister_all(arg_0);
    }

    function alias()
    {
        self.status.verify("Test Rosella.Container.alias()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.alias(arg_0, arg_1);
    }

    function resolve()
    {
        self.status.verify("Test Rosella.Container.resolve()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.resolve(arg_0);
    }

    function __sort_options()
    {
        self.status.verify("Test Rosella.Container.__sort_options()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.__sort_options(arg_0, arg_1);
    }

    function __resolve_internal()
    {
        self.status.verify("Test Rosella.Container.__resolve_internal()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.__resolve_internal(arg_0, arg_1);
    }

    function __multiple_resolvers_error()
    {
        self.status.verify("Test Rosella.Container.__multiple_resolvers_error()");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.__multiple_resolvers_error(arg_0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container);
}



class ContainerTest {
    method test_resolve_default_factory() {
        my $c := Rosella::construct(Rosella::Container);
        # No previous registration, falls back to the default object factory
        my $item := $c.resolve("String");
        $!assert.instance_of($item, "String");
    }

    method test_resolve_default_factory_with_args() {
        my $c := Rosella::construct(Rosella::Container);
        # No previous registration, falls back to the default object factory
        # Pass arguments to the constructor
        my $item := $c.resolve(MyTestClass, 1, 2);
        $!assert.instance_of($item, MyTestClass);
        $!assert.equal($item.a, 1);
        $!assert.equal($item.b, 2);
    }

    method test_resolve_create() {
        my $c := Rosella::construct(Rosella::Container);
        my $item := $c.resolve_create("String");
        $!assert.instance_of($item, "String");
    }

    method test_register_factory_method() {
        my $c := Rosella::construct(Rosella::Container);
        $c.register_factory_method("Foobar", sub () {
            return pir::box__PI(7);
        });
        my $i := $c.resolve("Foobar");
        $!assert.equal($i, 7, "not equal");
    }

    method test_register_type_withactions() {
        my $c := Rosella::construct(Rosella::Container);
        $c.register_type("String",
            :meth_inits([
                Rosella::construct(Rosella::Action::Sub,
                    sub ($obj) {
                        pir::set__vPS($obj, "FooBarBaz");
                    }, []
                ),
                Rosella::construct(Rosella::Action::Method,
                    "replace", [
                        Rosella::construct(Rosella::Action::Argument::Instance, "B", :position(0)),
                        Rosella::construct(Rosella::Action::Argument::Instance, "C", :position(1))
                    ]
                )
            ]
        ));
        my $bar := $c.resolve("String");
        $!assert.equal($bar, "FooCarCaz", "not equal");
    }
}
