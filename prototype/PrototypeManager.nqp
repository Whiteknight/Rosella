# A basic class for handling prototypes only. Much lighter-weight than
# Rosella::Container
class Rosella::Prototype::Manager {
    has %!library;

    method initialize(*%lib) {
        %!library := { };
    }

    method add_prototype($name, $proto, &sub?) {
        my $entry := Rosella::build(Rosella::Prototype::Item, $proto, &sub);
        %!library{$name} := $entry
    }

    method instance($name, *@pos, *%named) {
        return %!library{$name}.create(@pos, %named);
    }

    method get_prototype($name) {
        return %!library{$name}.prototype();
    }

    method get_constructor($name) {
        return %!library{$name}.constructor();
    }
}
