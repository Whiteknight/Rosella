// Automatically generated test for NameSpace Rosella.Query.Sort
class Test_Rosella_Query_Sort
{
    function quicksort()
    {
        self.status.verify("Test Rosella.Query.Sort.quicksort()");
        self.status.unimplemented("TODO");
        using Rosella.Query.Sort.quicksort;

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var result = quicksort(arg_0, arg_1, arg_2, arg_3);
    }

    function hybrid_quicksort()
    {
        self.status.verify("Test Rosella.Query.Sort.hybrid_quicksort()");
        self.status.unimplemented("TODO");
        using Rosella.Query.Sort.hybrid_quicksort;

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var arg_3 = null;
        var result = hybrid_quicksort(arg_0, arg_1, arg_2, arg_3);
    }

    function timsort()
    {
        self.status.verify("Test Rosella.Query.Sort.timsort()");
        self.status.unimplemented("TODO");
        using Rosella.Query.Sort.timsort;

        var arg_0 = null;
        var arg_1 = null;
        var result = timsort(arg_0, arg_1);
    }

    function get_default_comparer()
    {
        self.status.verify("Test Rosella.Query.Sort.get_default_comparer()");
        using Rosella.Query.Sort.get_default_comparer;

        var result = get_default_comparer();
        self.assert.instance_of(result, "Sub");
    }

    function get_reverse_comparer()
    {
        self.status.verify("Test Rosella.Query.Sort.get_reverse_comparer()");
        using Rosella.Query.Sort.get_reverse_comparer;

        var result = get_reverse_comparer();
        self.assert.instance_of(result, "Sub");
    }

    function get_unmoving_comparer()
    {
        self.status.verify("Test Rosella.Query.Sort.get_unmoving_comparer()");
        using Rosella.Query.Sort.get_unmoving_comparer;

        var result = get_unmoving_comparer();
        self.assert.instance_of(result, "Sub");
    }

    function get_randomizing_comparer()
    {
        self.status.verify("Test Rosella.Query.Sort.get_randomizing_comparer()");
        using Rosella.Query.Sort.get_randomizing_comparer;

        var result = get_randomizing_comparer();
        self.assert.instance_of(result, "Sub");
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Sort);
}
