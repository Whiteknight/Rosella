// Automatically generated test for Class Rosella.Random.RandomNumber.BoxMullerNormal
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Random.RandomNumber.BoxMullerNormal(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Random_RandomNumber_BoxMullerNormal
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Random.RandomNumber.BoxMullerNormal(0.0, 0.25);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Random.RandomNumber.BoxMullerNormal);
    }

    function distribution()
    {
        self.status.verify("Test Rosella.Random.RandomNumber.BoxMullerNormal.distribution()");
        var obj = create_new(0.0, 0.25);

        string result = obj.distribution();
        self.assert.equal(result, "normal");
    }

    function get_int()
    {
        self.status.verify("Test Rosella.Random.RandomNumber.BoxMullerNormal.get_int()");
        var obj = create_new(0.0, 0.25);

        int result = obj.get_int();
    }

    function get_float()
    {
        self.status.verify("Test Rosella.Random.RandomNumber.BoxMullerNormal.get_float()");
        var obj = create_new(0.0, 0.25);

        float result = obj.get_float();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/random.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Random_RandomNumber_BoxMullerNormal);
}
