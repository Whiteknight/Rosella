# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Cuculus::Verifier;

has $!sig_matcher;
has $!match_count;
has %!conditions;

our method conditions($value?) {
    %!conditions := pir::defined($value) ?? $value !! %!conditions;
}

our method verify($cuckoo) {
    my $matcher := $!sig_matcher;
    my $count := $!match_count := 0;

    for $cuckoo.call_log -> $callsig {
        $count++ if $matcher.matches($callsig);
    }

    self.was_called;
}

our method sig_matcher($value?) {
    pir::defined($value) ?? ($!sig_matcher := $value) !! $!sig_matcher;
}

our method was_called(*%named) {
    my %match := Hash::merge(%!conditions, %named);

    unless %match.contains: <times> {
        %match<times> := 1 if %match<once>;
        %match<times> := 2 if %match<twice>;
        %match<times> := 3 if %match<thrice>;
    }

    my $count := $!match_count;

    if %match<never> {
        Assert::true( $count == 0, 'At least one call made to :never callsig.');
    }
    elsif %match.contains: <times> {
        Assert::true( $count == %match<times>,
            "Wrong number of calls ($count) to callsig. Want exactly " ~ %match<times>);
    }
    else {
        if %match.contains: <at_least> {
            Assert::false( $count < %match<at_least>,
                    'Too few calls ($count) made to callsig. Expected at least ' ~ %match<at_least> ~ '.' );
        }

        if %match.contains: <at_most> {
            Assert::false( $count > %match<at_most>,
                    'Too many calls ($count) made to callsig. Expected at most ' ~ %match<at_most> ~ '.' );
        }
    }

    self; # Call-chaining
}
