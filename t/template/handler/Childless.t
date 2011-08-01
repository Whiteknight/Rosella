class Test_Rosella_Template_Handler_Childless
{
    function test_new() {
        var obj = new Rosella.Template.Handler.Childless([]);
        self.assert.not_null(obj);
        self.assert.instance_of(obj, class Rosella.Template.Handler.Childless);
    }

    function can_have_children() {
        self.status.verify("Test Rosella.Template.Handler.Childless.can_have_children()");
        var obj = new Rosella.Template.Handler.Childless([]);

        var result = obj.can_have_children();
        self.assert.is_false(result);
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template_Handler_Childless);
}
