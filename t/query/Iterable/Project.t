// Automatically generated test for Class Rosella.Query.Iterable.Project
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Project(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Project
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new()
    {
        // Test simple constructor. For most individual method tests, use create_new() above
        var obj = new Rosella.Query.Iterable.Project();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Query.Iterable.Project);
    }


    function Project()
    {
        self.status.verify("Test Rosella.Query.Iterable.Project.Project()");
        var obj = create_new();

        var arg_0 = null;
        var arg_1 = null;
        var result = obj.Project(arg_0, arg_1);
    }

    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Project.next()");
        var obj = create_new();

        var result = obj.next();
    }

    function has_more()
    {
        self.status.verify("Test Rosella.Query.Iterable.Project.has_more()");
        var obj = create_new();

        var result = obj.has_more();
    }

    function reset()
    {
        self.status.verify("Test Rosella.Query.Iterable.Project.reset()");
        var obj = create_new();

        var result = obj.reset();
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Project);
}
