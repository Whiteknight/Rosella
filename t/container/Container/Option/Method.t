class MyTestClass
{
    var a;
    function test_method_a() { self.a = 1; }
    function test_method_b(var value) { self.a = value; }
}

class Test_Rosella_Container_Option_Method
{
    function test_no_args()
    {
        var c = new Rosella.Container();
        c.register(class MyTestClass, new Rosella.Container.Option.Method("test_method_a"));
        var obj = c.resolve(class MyTestClass);
        self.assert.equal(obj.*"a", 1);
    }

    function test_with_args()
    {
        var c = new Rosella.Container();
        c.register(class MyTestClass,
            new Rosella.Container.Option.Method("test_method_b",
                new Rosella.Container.Argument.Instance(4)
            )
        );
        var obj = c.resolve(class MyTestClass);
        self.assert.equal(obj.*"a", 4);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/container.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Container_Option_Method);
}
