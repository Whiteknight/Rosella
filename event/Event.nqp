class ParrotContainer::Event {
    has %!actions;

    method BUILD(*%acts) {
        %!actions := %acts;
    }

    method add_action($name, $action) {
        %!actions{$name} := $action;
    }

    method get_action($name) {
        %!actions{$name};
    }

    method remove_action($name) {
        # TODO
    }

    method raise(@pos, %named) {
        for %!actions {
            %!actions{$_}.execute(self, @pos, %named);
        }
    }
}
