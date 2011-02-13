# Copyright (C) 2009-2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

module Assert;

our sub _initload() { }

our sub fail($why) {
    my $ex := Exception::UnitTestFailure.new();
    $ex.message($why);
    $ex.throw();
}

our sub block($message, &block) {
    fail($message) unless &block();
}

our sub block_false($message, &block) {
    fail($message) if &block();
}

our sub can($obj, $method, $message) {
    fail($message) unless pir::can($obj, $method);
}

our sub can_not($obj, $method, $message) {
    fail($message) if pir::can($obj, $method);
}

our sub defined($obj, $message) {
    fail($message) unless pir::defined($obj);
}

our sub not_defined($obj, $message) {
    fail($message) if pir::defined($obj);
}

our sub does($obj, $role, $message) {
    fail($message) unless pir::class__PP($obj).does($role);
}

our sub does_not($obj, $role, $message) {
    fail($message) if pir::class__PP($obj).does($role);
}

our sub equal($o1, $o2, $message) {
    fail($message) unless pir::iseq__IPP($o2, $o1);
}

our sub not_equal($o1, $o2, $message) {
    fail($message) if pir::iseq__IPP($o2, $o1);
}

our sub instance_of($obj, $class, $message) {
    fail($message) unless pir::class__PP($obj) =:= P6metaclass.get_parrotclass($class);
}

our sub not_instance_of($obj, $class, $message) {
    fail($message) if pir::class__PP($obj) =:= P6metaclass.get_parrotclass($class);
}

our sub isa($obj, $class, $message) {
    fail($message) unless pir::isa__iPP($obj, P6metaclass.get_parrotclass($class));
}

our sub not_isa($obj, $class, $message) {
    fail($message) if pir::isa__iPP($obj, P6metaclass.get_parrotclass($class));
}

our sub match($obj, $matcher, $message) {
    unless $matcher.matches($obj) {
        my $explain := $matcher.describe_self("\nExpected ")
            ~ $matcher.describe_failure("\nbut ", $obj);
        fail($message ~ $explain);
    }
}

our sub not_match($obj, $matcher, $message) {
    if $matcher.matches($obj) {
        fail($message);
    }
}

our sub null($obj, $message) {
    fail($message) unless pir::isnull($obj);
}

our sub not_null($obj, $message) {
    fail($message) if pir::isnull($obj);
}

our sub same($o1, $o2, $message) {
    fail($message) unless $o1 =:= $o2;
}

our sub not_same($o1, $o2, $message) {
    fail($message) if $o1 =:= $o2;
}

our sub throws($message, &block) {
    my $exception;

    try {
        &block();

        CATCH { $exception := $!; }
    };

    unless pir::defined($exception) {
        fail($message);
    }
}

our sub throws_nothing($message, &block) {
    my $ok := 1;

    try {
        &block();
        CATCH { $ok := 0; }
    };

    fail($message) unless $ok;
}

our sub true($bool, $message) {
    fail($message) unless $bool;
}

our sub false($bool, $message) {
    fail($message) if $bool;
}

our sub within_delta($o1, $o2, $delta, $message) {
    my $difference := $o1 - $o2;
    $difference := - $difference if $difference < 0;
    fail($message) unless $difference < $delta;
}

#~ like(obj, regex, message)
#~ not_like

our sub want_fail($message, &block) {
    throws(Exception::UnitTestFailure, $message, &block);
}

our sub want_pass($message, &block) {
    throws_nothing($message, &block);
}
