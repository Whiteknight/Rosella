# A method initializer calls a method on the new object, using a
# series of predefined arguments.
class ParrotContainer::Container::MethodInitializer {
    has $!method;
    has @!args;   # a list of Container::InitializerArgs

    method BUILD($method, @args) {
        $!method := $method;
        @!args := @args;
    }

    method execute($obj) {
        my @pos := [];
        my %named := {};
        self.prepare_args(@pos, %named);
        ParrotContainer::call_parrot_method($obj, $!method, @pos, %named);
    }

    method prepare_args(@pos, %named) {
        for @!args {
            $_.resolve_to(@pos, %named);
        }
    }
}
