# A method initializer calls a method on the new object, using a
# series of predefined arguments.
class Rosella::Action {
    has $!method;
    has @!args;   # a list of ActionArgs

    method BUILD($method, @args?) {
        $!method := $method;
        if pir::defined(@args) {
            @!args := @args;
        } else {
            @!args := [];
        }
    }

    method prepare_args(@pos, %named, @overrides?) {
        for @!args {
            $_.resolve_to(@pos, %named);
        }
        if pir::defined(@overrides) {
            for @overrides {
                $_.resolve_to(@pos, %named);
            }
        }
    }

    method execute($obj, @overrides?) {
        my @pos := [];
        my %named := {};
        self.prepare_args(@pos, %named, @overrides);
        self.execute_initializer($obj, @pos, %named);
    }
}

class Rosella::Action::Method is Rosella::Action {
    method execute_initializer($obj, @pos, %named) {
        Rosella::call_parrot_method($obj, $!method, @pos, %named);
    }
}

class Rosella::Action::Sub is Rosella::Action {
    method execute_initializer($obj, @pos, %named) {
        $!method($obj, |@pos, |%named);
    }
}
