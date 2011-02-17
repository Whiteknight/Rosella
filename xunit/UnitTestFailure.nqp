class Exception::RosellaFailure {
    has $!exception;

    our method message(*@value) {
        my $msg := pir::join(" ", @value);
        if !pir::defined__IP($!exception) {
            $!exception := Q:PIR { %r = new ["Exception"] };
        }
        my $ex := $!exception;
        Q:PIR {
            $P0 = find_lex "$ex"
            $P1 = find_lex "$msg"
            setattribute $P0, "message", $P1
        }
    }

    our method throw() {
        my $ex := $!exception;
        Q:PIR {
            $P0 = find_lex "$ex"
            throw $P0
        }
    }
}
