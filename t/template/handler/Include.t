// Automatically generated test for Class Rosella.Template.Handler.Include
class Test_Rosella_Template_Handler_Include
{
    function test_sanity()
    {
        self.assert.is_true(1);
    }

    function test_new() {
        var obj = new Rosella.Template.Handler.Include();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Include);
    }


    function Include() {
        self.status.verify("Test Rosella.Template.Handler.Include.Include()");
        var obj = new Rosella.Template.Handler.Include();

        var arg_0 = null;
        var result = obj.Include(arg_0);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Handler.Include.render()");
        var obj = new Rosella.Template.Handler.Include();

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
    test(class Test_Rosella_Template_Handler_Include);
}
