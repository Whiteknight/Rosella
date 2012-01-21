// Automatically generated test for NameSpace Rosella.Reflect.Module
class Test_Rosella_Reflect_Module
{
    function load()
    {
        self.status.verify("Test Rosella.Reflect.Module.load()");
        using Rosella.Reflect.Module.load;

        string arg_0 = "rosella/random.pbc";
        var result = load(arg_0);
        self.assert.not_null(result);
        self.assert.instance_of(result, class Rosella.Reflect.Module);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/reflect.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Reflect_Module);
}
