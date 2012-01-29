class Test_B
{
    function test_1A()
    {
    }

    function test_1B()
    {
    }
}

class Test_A
{
    function test_1()
    {
        self.status.suite().subtest(class Test_B);
    }

    function test_2()
    {
        self.status.suite().subtest_list([
            function () { },
            function () { },
            function () { }
        ]);
    }

    function test_3()
    {
        self.status.suite().subtest_vector(
            function(var x, var y) { },
            [1, 2, 3, 4, 5]
        );
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.Test.test)(class Test_A);
}

