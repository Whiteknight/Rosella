# Copyright (C) 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class UnitTest::Listener {
    our method add_error($failure) { }
    our method add_failure($failure) { }
    our method end_test($test) { }
    our method start_test($test) { }
}

class UnitTest::Listener::TAP is UnitTest::Listener;

has $!test_builder;

INIT {
    # TODO: Don't use Test::Builder here.
    pir::load_bytecode('Test/Builder.pbc');
}

our method add_error($failure) {
    self.add_failure($failure);	# Same for our purposes
}

our method add_failure($failure) {
    my $test := $failure.test_case;
    my $label := self.get_test_label($test);

    if $test.todo {
        $!test_builder.todo(0, $label, $test.todo);
    }
    else {
        $!test_builder.ok(0, self.get_test_label($failure.test_case));
    }

    $!test_builder.diag( $failure.fault.message );
    self;
}

our method end_test($test) {
    my $label := self.get_test_label($test);

    if $test.todo {
        $!test_builder.todo(1, $label, $test.todo);
    }
    else {
        $!test_builder.ok(1, self.get_test_label($test));
    }

    self;
}

our method get_test_label($test) {
    $test.verify || $test.name || '';
}

our method _init_obj(*@pos, *%named) {
    %named<test_builder> := Parrot::new('Test::Builder')
        unless %named.contains(<test_builder>);

    self._init_args(|@pos, |%named);
}

our method plan_tests($num_tests) {
    $!test_builder.plan($num_tests);
}

our method test_builder($tb?) {
    if pir::defined($tb) {
        $!test_builder := $tb;
        self;
    }
    else {
        $!test_builder;
    }
}
