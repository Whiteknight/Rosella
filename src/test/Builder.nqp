# a TAP output builder, to replace Test;Builder from the Parrot standard lib
class Rosella::Test::Builder {
    has $!test_number;

    method BUILD() {
        $!test_number := 0;
    }

    method reset() {
        $!test_number := 0;
    }

    method todo($pass, $msg, $todo?) {
        $!test_number := $!test_number + 1;
        my $output := self._get_result_text($!test_number, $pass, $msg);
        pir::say("$output # TODO $todo");
    }

    method ok($pass, $msg?) {
        $!test_number := $!test_number + 1;
        pir::say(self._get_result_text($!test_number, $pass, $msg));
    }

    method _get_result_text($number, $pass, $msg) {
        my $result := ($pass ?? "ok " !! "not ok ") ~ $number;
        if pir::defined($msg) {
            return "$result - $msg";
        } else {
            return $result;
        }
    }

    method diag($msg) {
        pir::say("# $msg");
    }

    method plan($count) {
        pir::say("1..$count");
    }
}
