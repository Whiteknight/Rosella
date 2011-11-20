class MyTestClass
{
    var a;
    var b;
    function MyTestClass(var a, var b) { self.a = a; self.b = b; }
    function a() { return self.a; }
    function b() { return self.b; }
}

class MySimpleTestClass { }

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

        var arg_0 = class MyTestClass;
        obj.register(arg_0);
        int result = obj.is_registered(arg_0);
        self.assert.is_true(result);
    }

    function unregister()
    {
        self.status.verify("Test Rosella.Container.unregister()");
        var obj = create_new();

        var arg_0 = class MyTestClass;
        obj.register(arg_0);
        int result = obj.is_registered(arg_0);
        self.assert.is_true(result);
        obj.unregister(arg_0);
        result = obj.is_registered(arg_0);
        self.assert.is_false(result);
    }

    function unregister_with_multiple_registrations()
    {
        self.status.verify(".unregister() with multiple registrations");
        var obj = create_new();

        var arg_0 = class MyTestClass;
        obj.register(arg_0);
        obj.register(arg_0);
        int result = obj.is_registered(arg_0);
        self.assert.is_true(result);
        obj.unregister(arg_0);
        result = obj.is_registered(arg_0);
        self.assert.is_true(result);
        obj.unregister(arg_0);
        result = obj.is_registered(arg_0);
        self.assert.is_false(result);
    }

    function unregister_all()
    {
        self.status.verify("Test Rosella.Container.unregister_all()");
        var obj = create_new();

        var arg_0 = class MyTestClass;
        obj.register(arg_0);
        obj.register(arg_0);
        int result = obj.is_registered(arg_0);
        self.assert.is_true(result);
        obj.unregister_all(arg_0);
        result = obj.is_registered(arg_0);
        self.assert.is_false(result);
    }

    function alias()
    {
        self.status.verify("Test Rosella.Container.alias()");
        var obj = create_new();

        var arg_0 = class MyTestClass;
        var arg_1 = "test class";
        obj.register(arg_0);
        obj.alias(arg_0, arg_1);
        int result = obj.is_registered(arg_1);
        self.assert.is_true(result);
    }

    function resolve()
    {
        self.status.verify("Test Rosella.Container.resolve()");
        var obj = create_new();

        // This test will cover basic error handling. We'll be exercising
        // .resolve() enough in other tests

        var arg_0 = null;
        self.assert.throws(function() {
            var result = obj.resolve(arg_0);
        });
    }

    function resolve_unregistered()
    {
        self.status.verify(".resolve() with previously unregistered type");
        var obj = create_new();

        string arg_0 = "String";
        var result = obj.resolve(arg_0);
        self.assert.instance_of(result, "String");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container);
}

