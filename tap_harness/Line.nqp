class Rosella::Harness::Line {
    has $!result;
    has $!number;
    has $!name;
    has $!comment;
    has $!ignore;

    method set_line($line) {
        my $idx := pir::index__ISS($line, "ok");
        if $idx != 0 && $idx != 4 {
            $!ignore := 1;
            return;
        } else {
            $!ignore := 0;
            my @line_parts := pir::split("ok ", $line);
            if @line_parts[0] eq 'not ' {
                $!result := 0;
                $!name := pir::split(' - ', $line)[1];
            }
            else {
                $!result := 1;
            }
            $!number := pir::split(' ', @line_parts[1])[0];
        }
    }

    method ignore() {
        return $!ignore;
    }

    method success() {
        return $!result;
    }

    method number() {
        return $!number;
    }

    method name() {
        return $!name;
    }
}
