class Test_Rosella_Template_Handler_Children
{
    function test_new() {
        var obj = new Rosella.Template.Handler.Children();
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Children);
    }

    function can_have_children() {
        self.status.verify("Test Rosella.Template.Handler.Children.can_have_children()");
        var obj = new Rosella.Template.Handler.Children([]);

        var result = obj.can_have_children();
        self.assert.is_true(result);
    }

    function add_child() {
        var obj = new Rosella.Template.Handler.Children([]);
        self.assert.throws_nothing(function() {
            obj.add_child("a");
        });
    }

    function __render_children() {
        self.status.unimplemented("Need Mocks");
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Handler_Children);
}
