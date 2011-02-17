class ParrotContainer::ActionArg {
    has $!name;
    has $!position;

    method name($value) {
        my $undef;
        $!name := $value;
        $!position := $undef;
    }

    method position($value) {
        my $undef;
        $!name := $undef;
        $!position := $value;
    }

    method type() {
        if pir::defined($!name) {
            return "Named";
        }
        if pir::defined($!position) {
            return "Positional";
        }
        return "Unknown";
    }

    # Prepare the argument, placing it in the correct aggregate. Positional
    # arguments go in @pos, named arguments go in %named
    method resolve_to(@pos, %named) {
        my $value := self.resolve_value();
        my $type := self.type();
        if $type eq "Named" {
            %named{$!name} := $value;
        } elsif $type eq "Positional" {
            if $!position >= 0 {
                @pos[$!position] := $value;
            } else {
                pir::push(@pos, $value);
            }
        } else {
            pir::die("Method argument must be Named or Positional");
        }
    }

    method resolve_value() {
        pir::die("Must use a subclass");
    }

}

# A type to be resolved recursively by the container
class ParrotContainer::ActionArg::ContainerResolver
    is ParrotContainer::ActionArg
{
    has $!container;
    has $!type;

    method BUILD($container, $type) {
        $!container := $container;
        $!type := $type;
    }

    method resolve_value() {
        return $!container.resolve($!type);
    }
}

# An explicit item instance to be passed
class ParrotContainer::ActionArg::Instance
    is ParrotContainer::ActionArg
{
    has $!instance;

    method BUILD($instance, :$position?, :$name?) {
        $!instance := $instance;
        if pir::defined($position) {
            self.position($position);
        }
        if pir::defined($name) {
            self.name($name);
        }
    }

    method resolve_value() {
        return $!instance;
    }
}
