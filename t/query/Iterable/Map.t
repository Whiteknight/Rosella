// Automatically generated test for Class Rosella.Query.Iterable.Map
function create_new(var p_args [slurpy], var n_args [slurpy,named])
{
    return new Rosella.Query.Iterable.Map(p_args:[flat], n_args:[flat,named]);
}

class Test_Rosella_Query_Iterable_Map
{
    function next()
    {
        self.status.verify("Test Rosella.Query.Iterable.Map.next()");
        self.status.unimplemented("TODO");
        var obj = create_new();

        var result = obj.next();
    }

    function map()
    {
        self.status.verify("Test mapping with chains");
        var m = Rosella.Query.iterable([1, 2, 3, 4])
            .map(function (int x) { return x * 5; })
            .map(function (int x) { return x + 2; });
        self.assert.equal(m.next(), 7);
        self.assert.equal(m.next(), 12);
        self.assert.equal(m.next(), 17);
        self.assert.equal(m.next(), 22);
        self.assert.is_false(m.has_more());
    }
}

function main[main]()
{
    var core = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("test");
    var(Rosella.load_bytecode_file)("rosella/query.pbc", "load");
    var(Rosella.Test.test)(class Test_Rosella_Query_Iterable_Map);
}
