class Test_Rosella_Template_Node
{
    function test_new()
    {
        var obj = new Rosella.Template.Node("", "");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node);
    }

    function type()
    {
        self.status.verify("Test Rosella.Template.Node.type()");
        var obj = new Rosella.Template.Node("foo", "bar");

        var result = obj.type();
        self.assert.equal(result, "bar");
    }

    function render()
    {
        self.status.verify("Test Rosella.Template.Node.render()");
        var obj = new Rosella.Template.Node("foo", "bar");

        self.assert.throws(function() {
            var arg_0 = null;
            var arg_1 = null;
            var arg_2 = null;
            var result = obj.render(arg_0, arg_1, arg_2);
        });
    }

    function assemble()
    {
        self.status.verify("Test Rosella.Template.Node.assemble()");
        var obj = new Rosella.Template.Node("foo", "bar");

        var nodec = (new Rosella.MockObject.Factory()).create_typed(class Rosella.Template.Node);
        nodec.expect_method("add_child").once().with_args(obj);

        var arg_0 = null; // ignored
        var arg_1 = nodec.mock();
        var result = obj.assemble(arg_0, arg_1);
        nodec.verify();
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/mockobject.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node);
}
