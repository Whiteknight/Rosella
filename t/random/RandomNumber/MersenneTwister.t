// Automatically generated test for Class Rosella.Random.RandomNumber.MersenneTwister
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Random.RandomNumber.MersenneTwister(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Random_RandomNumber_MersenneTwister
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Random.RandomNumber.MersenneTwister();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Random.RandomNumber.MersenneTwister);
    }

    function distribution()
    {
        self.status.verify("Test Rosella.Random.RandomNumber.MersenneTwister.distribution()");
        var obj = create_new();

        string result = obj.distribution();
        self.assert.equal(result, "uniform");
    }

    function get_int()
    {
        self.status.verify("Test Rosella.Random.RandomNumber.MersenneTwister.get_int()");
        var obj = create_new();

        int result = obj.get_int();
    }

    function get_float()
    {
        self.status.verify("Test Rosella.Random.RandomNumber.MersenneTwister.get_float()");
        var obj = create_new();

        float result = obj.get_float();
        self.assert.is_true(result >= 0.0 && result <= 1.0);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/random.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Random_RandomNumber_MersenneTwister);
}
