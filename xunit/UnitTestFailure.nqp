class Rosella::TestFailure {
    has $!exception;

    our method message(*@value) {
        my $msg := pir::join(" ", @value);
        if !pir::defined__IP($!exception) {
            $!exception := pir::new__PS("Exception");
        }
        my $ex := $!exception;
        pir::setattribute__vPSP($ex, "message", $msg);
    }

    our method throw() {
        my $ex := $!exception;
        pir::throw__vP($ex);
    }
}
