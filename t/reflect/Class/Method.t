// Automatically generated test for Class Rosella.Reflect.Class.Method
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return Rosella.Reflect.get_class_reflector(class 'String');
}

class Test_Rosella_Reflect_Class_Method
{
    function invoke()
    {
        self.status.verify("Test Rosella.Reflect.Class.Method.invoke()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.invoke(arg_0, arg_1, arg_2);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/reflect.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Reflect_Class_Method);
}
