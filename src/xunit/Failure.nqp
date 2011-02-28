class Rosella::Failure {
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
