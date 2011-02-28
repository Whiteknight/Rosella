# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Cuculus::Antiphon;

has $!sig_matcher;
has @!side_effects;
has $!throw;
has $!return;
has $!invoke_count;

our method matches($call_sig) {
    $!sig_matcher.matches($call_sig);
}

our method _init_obj(*@pos, *%named) {
    $!invoke_count := 0;
    @!side_effects := [ ];

    self._init_args(|@pos, |%named);
}

our method invoke($callsig) {
    $!invoke_count++;
    my $object := $callsig.object; # Pass this to &do, or not?
    my $result := $object;
    my @pos := $callsig.positional;
    my %named := $callsig.named;

    for @!side_effects -> &do {
        $result := &do(|@pos, |%named);
    }

    if $!throw {
        # TODO: Exception classes?
        $!throw.throw;
    }

    if $!return {
        return $!return;
    }

    $result;
}

our method sig_matcher($value?) {
    pir::defined($value) ?? ($!sig_matcher := $value) !! $!sig_matcher;
}

our method will( :&do, :$return, :$throw ) {
    self.will_do(&do) if pir::defined(&do);
    self.will_return($return) if pir::defined($return);
    self.will_throw($throw) if pir::defined($throw);

    self;
}

our method will_do(&closure) {
    @!side_effects.push: &closure;
    self;
}

our method will_return($result) {
    $!return := $result;
    self;
}

our method will_throw($exception) {
    $!throw := $exception;
    self;
}
