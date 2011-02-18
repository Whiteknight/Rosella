# A basic class for handling prototypes only. Much lighter-weight than
# Rosella::Container
class Rosella::Prototype::Manager {
    has %!library;

    method BUILD() {
        %!library := { };
    }

    method add_prototype($name, $proto, &sub?) {
        my $entry := Rosella::build(Rosella::Prototype::Item, $proto, &sub);
        %!library{$name} := $entry
    }

    # Get a fresh instance
    method instance($name, *@pos, *%named) {
        my $entry := %!library{$name};
        my $obj := $entry.create();
        $entry.construct(@pos, %named);
        return $obj;
    }

    # Get a fresh instance, and run it through a specified constructor
    # instead of any already-registered constructors.
    method instance_constructor($name, &constructor, *@pos, *%named) {
        my $entry := %!library{$name};
        my $obj := $entry.create();
        Rosella::call_parrot_method($obj, &constructor, @pos, %named);
        return $obj;
    }

    method get_prototype($name) {
        return %!library{$name}.prototype();
    }

    method get_constructor($name) {
        return %!library{$name}.constructor();
    }
}
