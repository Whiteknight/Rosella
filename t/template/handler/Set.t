class Test_Rosella_Template_Handler_Set
{
    function test_new() {
        var obj = new Rosella.Template.Handler.Set();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Set);
    }

    function can_have_children() {
        self.status.verify("Test Rosella.Template.Handler.Set.can_have_children()");
        var obj = new Rosella.Template.Handler.Set();

        var result = obj.can_have_children();
    }

    function add_child() {
        self.status.verify("Test Rosella.Template.Handler.Set.add_child()");
        var obj = new Rosella.Template.Handler.Set();

        var arg_0 = null;
        var result = obj.add_child(arg_0);
    }

    function render() {
        self.status.verify("Test Rosella.Template.Handler.Set.render()");
        var obj = new Rosella.Template.Handler.Set();

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
    test(class Test_Rosella_Template_Handler_Set);
}
