# Copyright 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

module Cuculus::SigMatcher;
# is Matcher::CallSig?

our method object_matches($actual) {
    my $exp := $!expecting.object;
    my $act := $actual.object;

    $exp =:=  $act
    || $exp =:= ANY()
    || isa($exp, Cuculus::Canorus::Ovum) && isa($act, Cuculus::Canorus::Ovum)
        && Opcode::getattribute($exp, '$!CUCULUS_CANORUS') =:= Opcode::getattribute($act, '$!CUCULUS_CANORUS');
}

our method positionals_match($actual) {
    my @wanted := $!expecting.positional;
    my @got := $actual.positional;

    my $count := 0;
    my $num_expecting := @wanted;

    while $count < $num_expecting {
        my $want := @wanted[$count];
        return 1 if $want =:= ETC();
        return 0 if $count == @got;	# Could be ok if ETC() above.

        my $got := @got[$count];

        if $count == 0
            && isa($want, Cuculus::Canorus::Ovum) && isa($got, Cuculus::Canorus::Ovum)
            && get_cuckoo($want) =:= get_cuckoo($got) {
            # okay, they match.
        }
        elsif $want =:= ANY()
            || $want =:= $got
            || pir::iseq__IPP($want, $got) {
            # okay, they match
        }
        else {
            return 0;
        }

        $count++;
    }

    1;
}
