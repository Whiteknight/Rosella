// Automatically generated test for Class Rosella.Query.Provider.Scalar
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Provider.Scalar(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Provider_Scalar
{
    function foreach()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.foreach()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = 7;
        var arg_1 = null;
        var result = obj.foreach(arg_0, arg_1);
    }

    function map()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.map()");
        var obj = create_new();

        var arg_0 = 7;
        var arg_1 = function(i) { return i + 5; };
        int result = obj.map(arg_0, arg_1);
        self.assert.equal(result, 12);
    }

    function filter()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.filter()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = 7;
        var arg_1 = function(i) {};
        var result = obj.filter(arg_0, arg_1);
    }

    function fold()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.fold()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.fold(arg_0, arg_1, arg_2);
    }

    function count()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.count()");
        var obj = create_new();

        var arg_0 = 7;
        var arg_1 = null;
        int result = obj.count(arg_0, arg_1);
        self.assert.equal(result, 1);

        // TODO: Test the case with a predicate
    }

    function any()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.any()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = 7;
        var arg_1 = null;
        var result = obj.any(arg_0, arg_1);
    }

    function take()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.take()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.take(arg_0, arg_1, arg_2);
    }

    function project()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.project()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.project(arg_0, arg_1);
    }

    function unwrap_first()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.unwrap_first()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = null;
        var result = obj.unwrap_first(arg_0);
    }

    function to_array()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.to_array()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = 7;
        var result = obj.to_array(arg_0);
        self.assert.does(result, "array");
        self.assert.equal(elements(result), 1);
    }

    function to_hash()
    {
        self.status.verify("Test Rosella.Query.Provider.Scalar.to_hash()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var arg_0 = 7;
        var arg_1 = function(i) { return string(i); };
        var result = obj.to_hash(arg_0, arg_1);

        self.assert.does(result, "hash");
        self.assert.equal(elements(result), 1);
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Provider_Scalar);
}
