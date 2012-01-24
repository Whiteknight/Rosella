// Automatically generated test for Class Rosella.Query.Sort.Timsort
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Sort.Timsort(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Sort_Timsort
{
    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Sort.Timsort(Rosella.Query.Sort.get_default_comparer());
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Sort.Timsort);
    }

    function sort()
    {
        self.status.verify("Test Rosella.Query.Sort.Timsort.sort()");
        var obj = create_new(Rosella.Query.Sort.get_default_comparer());

        var arg_0 = [1,2,3,4,5,7,6,8,9];
        var arg_1 = 0;
        var arg_2 = elements(arg_0);
        obj.sort(arg_0, arg_1, arg_2);
        self.assert.is_match(arg_0, [1, 2, 3, 4, 5, 6, 7, 8, 9]);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Sort_Timsort);
}
