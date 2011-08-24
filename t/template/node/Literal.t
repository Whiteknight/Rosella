class Test_Rosella_Template_Node_Literal
{
    function test_new() {
        var obj = new Rosella.Template.Node.Literal("Foo", "Bar");
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Literal);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Literal.render()");
        self.status.unimplemented("Test this");
        var obj = new Rosella.Template.Node.Literal("contents", "");

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = new 'StringBuilder';
        obj.render(arg_0, arg_1, arg_2);
        self.assert.equal(string(arg_2), "contents");
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Literal);
}
