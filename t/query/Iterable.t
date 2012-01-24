// Automatically generated test for Class Rosella.Query.Iterable
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return Rosella.Query.iterable(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable
{
    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.next()");
        var obj = create_new([]);

        self.assert.throws(function() {
            obj.next();
        });
    }

    function to_array()
    {
        self.status.verify("Test Rosella.Query.Iterable.to_array()");
        var obj = create_new([1,2,3]);

        var result = obj.to_array();
        self.assert.does(result, "array");
    }

    function to_hash()
    {
        self.status.verify("Test Rosella.Query.Iterable.to_hash()");
        var obj = create_new([1,2,3]);

        var arg_0 = function(i) { return string(i); };
        var result = obj.to_hash(arg_0);
        self.assert.does(result, "hash");

        arg_0 = function(i) { return string(i); };
        var arg_1 = function(i) { return i + 5; };
        result = obj.to_hash(arg_0, arg_1);
        self.assert.does(result, "hash");
        // TODO: Test that the values are as expected
    }

    function foreach()
    {
        self.status.verify("Test Rosella.Query.Iterable.foreach()");
        var obj = create_new([1, 2, 3]);

        int sum = 0;
        var arg_0 = function(i) { sum = sum + i; };
        obj.foreach(arg_0);
        self.assert.equal(sum, 6);
    }

    function execute()
    {
        self.status.verify("Test Rosella.Query.Iterable.execute()");
        self.status.unimplemented("TODO");
        var obj = create_new([]);

        var result = obj.execute();
    }

    function fold()
    {
        self.status.verify("Test Rosella.Query.Iterable.fold()");
        var obj = create_new([1,2,3,4,5]);

        var arg_0 = function(s, i) { return s + i; };
        int result = obj.fold(arg_0);
        self.assert.equal(result, 15);

        obj = create_new([1,2,3,4,5]);
        int arg_1 = 7;
        result = obj.fold(arg_0, arg_1);
        self.assert.equal(result, 22);
    }

    function map()
    {
        self.status.verify("Test Rosella.Query.Iterable.map()");
        var obj = create_new([1,2,3]);

        var arg_0 = function(i) { return string(i) + "foo"; };
        var result = obj.map(arg_0).to_array();
        self.assert.equal(result[0], "1foo");
        self.assert.equal(result[1], "2foo");
        self.assert.equal(result[2], "3foo");
    }

    function filter()
    {
        self.status.verify("Test Rosella.Query.Iterable.filter()");
        var obj = create_new([1,2,3]);

        var arg_0 = function(i) { return i % 2 == 0; };
        var result = obj.filter(arg_0);
        self.assert.equal(result.count(), 1);
    }

    function append()
    {
        self.status.verify("Test Rosella.Query.Iterable.append()");
        var obj = create_new([1,2,3]);

        var arg_0 = [4,5];
        var result = obj.append(arg_0);
        self.assert.equal(result.count(), 5);
    }

    function take()
    {
        self.status.verify("Test Rosella.Query.Iterable.take()");
        var obj = create_new([1,2,3,4,5]);
        int arg_0 = 3;
        var result = obj.take(arg_0);
        self.assert.equal(result.count(), 3);

        obj = create_new([1,2,3,4,5]);
        arg_0 = 7;
        result = obj.take(arg_0);
        self.assert.equal(result.count(), 5);
    }

    function skip()
    {
        self.status.verify("Test Rosella.Query.Iterable.skip()");
        var obj = create_new([1,2,3,4,5]);

        int arg_0 = 2;
        var result = obj.skip(arg_0);
        self.assert.equal(result.count(), 3);
    }

    function flatten()
    {
        self.status.verify("Test Rosella.Query.Iterable.flatten()");
        var obj = create_new([1, [2], [[3]], [4, [5], [6, [[7]], [], [[], []], 8]], 9]);

        var result = obj.flatten().to_array();
        self.assert.equal(elements(result), 9);
        self.assert.is_match(result, [1,2,3,4,5,6,7,8,9]);
    }

    function project()
    {
        self.status.verify("Test Rosella.Query.Iterable.project()");
        var obj = create_new([5, 10, 15]);

        var arg_0 = function(i) { return [i + 1, i + 2, i + 3]; };
        var result = obj.project(arg_0).to_array();
        self.assert.equal(elements(result), 9);
        var x = [6, 7, 8, 11, 12, 13, 16, 17, 18];
        self.assert.is_match(result, x);
    }

    function tap()
    {
        self.status.verify("Test Rosella.Query.Iterable.tap()");
        var obj = create_new([1, 2, 3, 4]);

        int sum = 0;
        var arg_0 = function(i) { sum = sum + int(i); };
        obj.tap(arg_0).execute();
        self.assert.equal(sum, 10);
    }

    function sort()
    {
        self.status.verify("Test Rosella.Query.Iterable.sort()");
        var obj = create_new([5,4,6,3,7,2,8,1,9]);

        var result = obj.sort().to_array();
        for (int i = 0; i < 9; i++)
            self.assert.equal(result[i], i + 1);
    }

    function cache_sort()
    {
        self.status.verify("Test Rosella.Query.Iterable.cache_sort()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.cache_sort(arg_0);
    }

    function shuffle()
    {
        self.status.verify("Test Rosella.Query.Iterable.shuffle()");
        self.status.unimplemented("TODO");
        var obj = create_new([1, 2, 3, 4, 5]);

        var result = obj.shuffle();
        // TODO: Is there a way we can test this?
    }

    function group_by()
    {
        self.status.verify("Test Rosella.Query.Iterable.group_by()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.group_by(arg_0);
    }

    function count()
    {
        self.status.verify("Test Rosella.Query.Iterable.count()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.count();
    }

    function any()
    {
        self.status.verify("Test Rosella.Query.Iterable.any()");
        var obj = create_new([]);
        int result = obj.any();
        self.assert.is_false(result);

        obj = create_new([1, 2, 3]);
        result = obj.any();
        self.assert.is_true(result);

        obj = create_new([1, 2, 3]);
        var arg_0 = function(i) { return i < 5; };
        result = obj.any(arg_0);
        self.assert.is_true(result);

        obj = create_new([1, 2, 3]);
        arg_0 = function(i) { return i > 5; };
        result = obj.any(arg_0);
        self.assert.is_false(result);
    }

    function single()
    {
        self.status.verify("Test Rosella.Query.Iterable.single()");
        var obj = create_new([9]);

        int result = obj.single();
        self.assert.equal(result, 9);

        self.assert.throws(function() {
            obj = create_new([]);
            result = obj.single();
        });

        self.assert.throws(function() {
            obj = create_new([1, 2]);
            result = obj.single();
        });

        // TODO: Test .single(f) with the filter argument
    }

    function first()
    {
        self.status.verify("Test Rosella.Query.Iterable.first()");
        var obj = create_new([9, 8, 7, 6]);

        int result = obj.first();
        self.assert.equal(result, 9);

        self.assert.throws(function() {
            obj = create_new([]);
            result = obj.first();
        });

        // TODO: test .first(f) with the filter argument
    }

    function first_or_default()
    {
        self.status.verify("Test Rosella.Query.Iterable.first_or_default()");
        var obj = create_new([1, 2, 3]);

        int result = obj.first_or_default();
        self.assert.equal(result, 1);

        obj = create_new([]);
        result = obj.first_or_default(5:[named("default")]);
        self.assert.equal(result, 5);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable);
}
