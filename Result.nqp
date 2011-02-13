# Copyright (C) 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class UnitTest::Failure {
    has $!fault;
    has $!test_case;

    our method fault($value?) {
        if pir::defined__IP($value) {
            $!fault := $value;
        }
        $!fault;
    }

    our method test_case($value?) {
        if pir::defined__IP($value) {
            $!test_case := $value;
        }
        $!test_case;
    }
}

class UnitTest::Result;

has @!errors;
has @!failures;
has @!listeners;
has $!should_stop;
has $!num_tests;
has $!planned_tests;

our method should_stop($value?) {
    if pir::defined($value) {
        $!should_stop := $value;
    }
    $!should_stop;
}

our method num_tests($value?) {
    if pir::defined($value) {
        $!num_tests := $value;
    }
    $!num_tests;
}

our method add_error($test, $error) {
    self.add_fault($test, $error, :notify('add_error'), :queue(@!errors));
}

our method add_failure($test, $failure) {
    self.add_fault($test, $failure, :notify('add_failure'), :queue(@!failures));
}

my method add_fault($test, $exception, :$notify, :$queue) {
    my $failure := UnitTest::Failure.new();
    $failure.fault($exception);
    $failure.test_case($test);

    $queue.push($failure);
    self.notify_listeners($notify, $failure);
}

our method add_listener($listener) {
    @!listeners.push($listener);
    self;
}

our method end_test($test) {
    self.notify_listeners('end_test', $test);
}

our method error_count() {
    pir::elements(@!errors);
}

our method failure_count() {
    pir::elements(@!failures);
}

my method notify_listeners($method, *@args, *%named) {
    for @!listeners {
        my $object := $_;
        Q:PIR {
            .local pmc object, meth, args, opts
            object = find_lex '$object'
            meth = find_lex '$method'
            args = find_lex '@args'
            opts = find_lex '%named'

            $I0 = isa meth, 'Sub'
            unless $I0 goto call_string

            object.meth(args :flat, opts :named :flat)

          call_string:
            $S0 = meth
            object.$S0(args :flat, opts :named :flat)
        };
    }

    self;
}

our method plan_tests($num_tests) {
    # Ignore repeats in hierarchy of suites.
    unless $!planned_tests {
        $!planned_tests := $num_tests;
        self.notify_listeners: 'plan_tests', $num_tests;
    }
}

our method remove_listener($listener) {
    my $index := 0;

    while $index < self.listeners.elems {
        if self.listeners[$index] =:= $listener {
            self.listeners.delete($index);
        }
        else {
            $index++;
        }
    }

    self;
}

our method run_count() {
    self.num_tests;
}

our method start_test($test) {
    self.num_tests(self.num_tests + $test.num_tests);
    self.notify_listeners('start_test', $test);
}

our method stop() {
    self.should_stop(1);
    self;
}

our method was_successful() {
    self.error_count == 0 && self.failure_count == 0;
}
