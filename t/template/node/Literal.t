// Automatically generated test for Class Rosella.Template.Node.Literal
class Test_Rosella_Template_Node_Literal
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Node.Literal();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Node.Literal);
    }


    function Literal() {
        self.status.verify("Test Rosella.Template.Node.Literal.Literal()");
        var obj = new Rosella.Template.Node.Literal();

        var arg_0 = null;
        var result = obj.Literal(arg_0);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Node.Literal.render()");
        var obj = new Rosella.Template.Node.Literal();

        var arg_0 = null;
        var arg_1 = null;
        var arg_2 = null;
        var result = obj.render(arg_0, arg_1, arg_2);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Node_Literal);
}
