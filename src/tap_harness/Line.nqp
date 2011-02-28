class Rosella::Harness::Line {
    has $!result;
    has $!number;
    has $!name;
    has $!ignore;
    has $!todo;

    method BUILD($line) {
        $!result := 0;
        $!number := -1;
        $!name := "";
        $!ignore := 0;
        $!todo := 0;
        if self.can_ignore($line) {
            $!ignore := 1;
            return;
        }
        self.parse_line($line);
    }

    method can_ignore($line) {
        if pir::length__IS($line) < 2 {
            return 1;
        }
        if pir::substr($line, 0, 1) eq "#" {
            return 1;
        }
        my $idx := pir::index__ISS($line, "ok");
        if $idx != 0 && $idx != 4 {
            return 1;
        }
        return 0;
    }

    method parse_line($line) {
        my @parts := pir::split__PSS("#", $line);
        my $result := pir::shift__PP(@parts);
        if +@parts > 0 {
            self.parse_comment(@parts[0]);
        }
        self.parse_result($result);
    }

    method parse_comment($comment) {
        if pir::index__ISS($comment, "TODO") {
            $!todo := 1;
        }
    }

    method parse_result($result) {
        my @line_parts := pir::split("ok ", $result);
        if @line_parts[0] eq 'not ' {
            $!result := 0;
            $!name := pir::split(' - ', $result)[1];
        }
        else {
            $!result := 1;
        }
        $!number := pir::split(' ', @line_parts[1])[0];
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

    method todo() {
        return $!todo;
    }
}
