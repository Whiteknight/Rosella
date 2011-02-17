class ParrotContainer::EventManager {
    has %!events;

    method BUILD() {
        %!events := {};
    }

    method register_event($name, $event) {
        # TODO: Behavior on duplicates/override?
        %!events{$name} := $event;
    }

    method raise_event($name, *@args, *%named) {
        %!events{$name}.raise(@args, %named);
    }

    method remove_event($name) {
    }
}
