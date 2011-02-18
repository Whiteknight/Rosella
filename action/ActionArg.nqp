class Rosella::ActionArg {
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

    method setup_positioning(:$position?, :$name?) {
        if pir::defined($position) {
            self.position($position);
        } elsif pir::defined($name) {
            self.name($name);
        }
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
        Rosella::Error::must_subclass(Rosella::ActionArg, "resolve_value");
    }

}

# A type to be resolved recursively by the container
class Rosella::ActionArg::ContainerResolver
    is Rosella::ActionArg
{
    has $!container;
    has $!type;

    method BUILD($container, $type, *%named) {
        $!container := $container;
        $!type := $type;
        self.setup_positioning(|%named);
    }

    method resolve_value() {
        return $!container.resolve($!type);
    }
}

# An explicit item instance to be passed
class Rosella::ActionArg::Instance
    is Rosella::ActionArg
{
    has $!instance;

    method BUILD($instance, *%named) {
        $!instance := $instance;
        self.setup_positioning(|%named);
    }

    method resolve_value() {
        return $!instance;
    }
}
