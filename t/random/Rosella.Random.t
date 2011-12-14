class Test_Rosella_Random
{
    // Tests for Functions

    function default_uniform_random()
    {
        self.status.verify("Test Rosella.Random.default_uniform_random()");
        using Rosella.Random.default_uniform_random;

        var result = default_uniform_random();
        self.assert.equal(result.distribution(), "uniform");
    }

    function default_normal_random()
    {
        self.status.verify("Test Rosella.Random.default_normal_random()");
        using Rosella.Random.default_normal_random;

        float arg_0 = 0.0;
        float arg_1 = 0.25;
        var result = default_normal_random(arg_0, arg_1);
        self.assert.equal(result.distribution(), "normal");
    }

    function shuffle_array()
    {
        self.status.verify("Test Rosella.Random.shuffle_array()");
        using Rosella.Random.shuffle_array;

        var arg_0 = [1, 2, 3, 4, 5];
        var result;
        int is_same = true;

        // There's a non-zero chance that shuffling will give us the same array.
        // Run this test a few times before declaring failure.
        for (int i = 0; i < 20; i++) {
            result = shuffle_array(arg_0);

            for (int j = 0; j < 5; j++) {
                if (arg_0[j] != result[j])
                    is_same = false;
            }
            if (!is_same)
                break;
        }
        self.assert.is_false(is_same);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/random.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Random);
}
