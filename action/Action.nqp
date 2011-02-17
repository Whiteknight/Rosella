# A method initializer calls a method on the new object, using a
# series of predefined arguments.
class ParrotContainer::Action {
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

    method prepare_args(@pos, %named) {
        for @!args {
            $_.resolve_to(@pos, %named);
        }
    }

    method execute($obj, @pos_args?, %named_args?) {
        my @pos;
        if pir::defined(@pos_args) {
            # TODO: We probably want a clone here. Don't reuse the same
            #       array since we are modifying it
            @pos := @pos_args;
        } else {
            @pos := [];
        }
        my %named;
        if pir::defined(%named_args) {
            %named := %named_args;
        } else {
            %named := {};
        }
        self.prepare_args(@pos, %named);
        self.execute_initializer($obj, @pos, %named);
    }
}

class ParrotContainer::Action::Method is ParrotContainer::Action {
    method execute_initializer($obj, @pos, %named) {
        ParrotContainer::call_parrot_method($obj, $!method, @pos, %named);
    }
}

class ParrotContainer::Action::Sub is ParrotContainer::Action {
    method execute_initializer($obj, @pos, %named) {
        $!method($obj, |@pos, |%named);
    }
}
