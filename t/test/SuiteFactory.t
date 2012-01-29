INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
}

class MyFakeTestClass {}

Rosella::Test::test(Test::SuiteFactory::Test);
class Test::SuiteFactory::Test {
    method basic_BUILD() {
        my $factory := Rosella::construct(Rosella::Test::SuiteFactory);
    }

    method test_create_Suite() {
        my %options := {};
        %options{"suite_type"} := Rosella::Test::Suite;
        my $factory := Rosella::construct(Rosella::Test::SuiteFactory);
        my $suite := $factory.create(Rosella::construct(Rosella::Test::TestFactory), {});
        $!assert.instance_of($suite, Rosella::Test::Suite);
    }

    method test_create_custom_suite() {
        $!status.unimplemented("test .create() with a custom type");
    }

    method test_create_typed_custom_suite() {
        $!status.unimplemented("test .create_typed() with a custom type");
    }

    method test_create_typed_Suite() {
        my $factory := Rosella::construct(Rosella::Test::SuiteFactory, Rosella::Test::Suite);
        my $suite := $factory.create_typed(Rosella::Test::Suite, Rosella::construct(Rosella::Test::TestFactory, Rosella::Test::TestCase), {});
        $!assert.instance_of($suite, Rosella::Test::Suite);
    }

    method test_testcase_subclass() {
        $!status.unimplemented("Test using SuiteFactory with a subclass of TestCase");
    }

    method test_context() {
        $!status.unimplemented("Test using a custom TestContext object. Show that it is passed to all tests in the Suite");
    }
}
