class Test_Rosella_Template
{
    function get_standard_template_file()
    {
        self.status.verify("Test Rosella.Template.get_standard_template_file()");
        using Rosella.Template.get_standard_template_file;

        string arg_0 = "test_ns.winxed";
        self.assert.throws_nothing(function() {
            var result = get_standard_template_file(arg_0);
            self.assert.not_equal(length(result), 0);
        });
    }

    function get_standard_template_file_FAIL()
    {
        self.status.verify("Test Rosella.Template.get_standard_template_file()");
        using Rosella.Template.get_standard_template_file;

        string arg_0 = "no such file";
        self.assert.throws(function() {
            var result = get_standard_template_file(arg_0);
        });
    }

    function get_standard_template_text()
    {
        self.status.verify("Test Rosella.Template.get_standard_template_text()");
        using Rosella.Template.get_standard_template_text;

        string arg_0 = "test_ns.winxed";
        self.assert.throws_nothing(function() {
            var result = get_standard_template_text(arg_0);
            self.assert.not_equal(length(result), 0);
        });
    }

    function get_standard_template_text_FAIL()
    {
        self.status.verify("Test Rosella.Template.get_standard_template_text()");
        using Rosella.Template.get_standard_template_text;

        string arg_0 = "no such file";
        self.assert.throws(function() {
            var result = get_standard_template_text(arg_0);
        });
    }
}

function main[main]()
{
    load_bytecode("rosella/test.pbc");
    load_bytecode("rosella/template.pbc");
    using Rosella.Test.test;
    test(class Test_Rosella_Template);
}
