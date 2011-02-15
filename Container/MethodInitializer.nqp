# A method initializer calls a method on the new object, using a
# series of predefined arguments.
class ParrotContainer::Initializer {
    has $!method;
    has @!args;   # a list of Container::InitializerArgs

    method BUILD($method, @args) {
        $!method := $method;
        @!args := @args;
    }

    method prepare_args(@pos, %named) {
        for @!args {
            $_.resolve_to(@pos, %named);
        }
    }

    method execute($obj) {
        my @pos := [];
        my %named := {};
        self.prepare_args(@pos, %named);
        self.execute_initializer($obj, @pos, %named);
    }
}

class ParrotContainer::Initializer::Method is ParrotContainer::Initializer {
    method execute_initializer($obj, @pos, %named) {
        ParrotContainer::call_parrot_method($obj, $!method, @pos, %named);
    }
}

class ParrotContainer::Initializer::Sub is ParrotContainer::Initializer {
    method execute_initializer($obj, @pos, %named) {
        $!method($obj, |@pos, |%named);
    }
}
