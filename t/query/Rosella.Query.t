// Automatically generated test for NameSpace Rosella.Query
class Test_Rosella_Query
{
    function as_queryable()
    {
        self.status.verify("Test Rosella.Query.as_queryable()");
        using Rosella.Query.as_queryable;

        var arg_0 = [];
        var result = as_queryable(arg_0);
        self.assert.instance_of(result, class Rosella.Query.Queryable);
    }

    function iterable()
    {
        self.status.verify("Test Rosella.Query.iterable()");
        using Rosella.Query.iterable;

        var arg_0 = [];
        var result = iterable(arg_0);
        self.assert.instance_of(result, class Rosella.Query.Iterable);
    }

    function wrap_iterator()
    {
        self.status.verify("Test Rosella.Query.wrap_iterator()");
        using Rosella.Query.wrap_iterator;

        var arg_0 = [];
        ${ iter arg_0, arg_0 };
        var result = wrap_iterator(arg_0);
        self.assert.instance_of(result, class Rosella.Query.Iterable);
    }

    function is_array()
    {
        self.status.verify("Test Rosella.Query.is_array()");
        using Rosella.Query.is_array;

        var arg_0 = [];
        int result = is_array(arg_0);
        self.assert.is_true(result);

        arg_0 = {};
        result = is_array(arg_0);
        self.assert.is_false(result);
    }

    function is_hash()
    {
        self.status.verify("Test Rosella.Query.is_hash()");
        using Rosella.Query.is_hash;

        var arg_0 = {};
        int result = is_hash(arg_0);
        self.assert.is_true(result);

        arg_0 = [];
        result = is_hash(arg_0);
        self.assert.is_false(result);
    }

    function is_iterator()
    {
        self.status.verify("Test Rosella.Query.is_iterator()");
        using Rosella.Query.is_iterator;

        var arg_0 = [];
        int result = is_iterator(arg_0);
        self.assert.is_false(result);

        ${ iter arg_0, arg_0 };
        result = is_iterator(arg_0);
        self.assert.is_true(result);

        arg_0 = new Rosella.Query.Iterable.Array([]);
        result = is_iterator(arg_0);
        self.assert.is_true(result);
    }

    function array_or_hash()
    {
        self.status.verify("Test Rosella.Query.array_or_hash()");
        using Rosella.Query.array_or_hash;

        var arg_0 = [];
        var arg_1 = function(x) { return 7; };
        var arg_2 = function(x) { self.assert.fail(); };
        var arg_3 = function(x) { self.assert.fail(); };
        int result = array_or_hash(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, 7);

        arg_0 = {};
        arg_1 = function(x) { self.assert.fail(); };
        arg_2 = function(x) { return 9; };
        arg_3 = function(x) { self.assert.fail(); };
        result = array_or_hash(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, 9);

        arg_0 = 5;
        arg_1 = function(x) { self.assert.fail(); };
        arg_2 = function(x) { self.assert.fail(); };
        arg_3 = function(x) { return 11; };
        result = array_or_hash(arg_0, arg_1, arg_2, arg_3);
        self.assert.equal(result, 11);
    }

    function install_to_type()
    {
        self.status.verify("Test Rosella.Query.install_to_type()");
        self.status.unimplemented("TODO");
        using Rosella.Query.install_to_type;

        var arg_0 = null;
        var result = install_to_type(arg_0);
    }

    function sort_array()
    {
        self.status.verify("Test Rosella.Query.sort_array()");
        using Rosella.Query.sort_array;

        var arg_0 = [5,4,6,3,7,2,8,1,9];
        var result = sort_array(arg_0);
        var c = [1, 2, 3, 4, 5, 6, 7, 8, 9];
        for (int i = 0; i < elements(arg_0); i++)
            self.assert.equal(arg_0[i], c[i]);
    }

    function default_provider_factory()
    {
        self.status.verify("Test Rosella.Query.default_provider_factory()");
        using Rosella.Query.default_provider_factory;

        var result = default_provider_factory();
        self.assert.instance_of(result, class Rosella.Query.Provider.Factory);
    }

    function set_provider_factory()
    {
        self.status.verify("Test Rosella.Query.set_provider_factory()");
        using Rosella.Query.set_provider_factory;
        using Rosella.Query.default_provider_factory;

        var arg_0 = [];
        set_provider_factory(arg_0);
        var result = default_provider_factory();
        self.assert.same(arg_0, result);
    }

    function default_iterable_factory()
    {
        self.status.verify("Test Rosella.Query.default_iterable_factory()");
        using Rosella.Query.default_iterable_factory;

        var result = default_iterable_factory();
        self.assert.instance_of(result, class Rosella.Query.Iterable.Factory);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query);
}
