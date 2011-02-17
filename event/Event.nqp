class ParrotContainer::Event {
    has %!actions;
    has $!current_action_name;
    has @!current_pos_payload;
    has %!current_named_payload;
    has $!handled;

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

    method VTABLE_get_pmc_keyed($key) is pirflags<:vtable("get_pmc_keyed")> {
        return %!current_named_payload{$key};
    }

    method VTABLE_get_pmc_keyed_int($key) is pirflags<:vtable("get_pmc_keyed_int")> {
        return @!current_pos_payload[$key];
    }

    method positional_payload() { @!current_pos_payload; }
    method named_payload() { %!current_named_payload; }
    method action_name() { $!current_action_name; }
    method handled($handled) {
        $!handled := $handled;
    }

    method raise(@pos, %named) {
        @!current_pos_payload := @pos;
        %!current_named_payload := %named;
        $!handled := 0;
        for %!actions {
            $!current_action_name := $_;
            %!actions{$_}.execute(self);
            last if $!handled;
        }
    }
}
