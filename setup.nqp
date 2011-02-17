INIT {
    pir::load_bytecode('distutils.pbc');
}

sub new_hash(*%args) { %args; }

MAIN(pir::getinterp__P()[2]);

sub MAIN(@argv) {
    my %pc := new_hash(
        :name('Parrot-Container'),
        :abstract('Type resolution and dependency injection for Parrot'),
        :authority('http://github.com/Whiteknight'),
        :copyright_holder('Andrew Whitworth'),
        :keywords(< container dependency-injection >),
        :license_type('Artistic License 2.0'),
        :license_uri('http://www.perlfoundation.org/artistic_license_2_0' ),
        :checkout_uri('git://github.com/Whiteknight/parrot-container.git' ),
        :browser_uri('git://github.com/Whiteknight/parrot-container'),
        :project_uri('git://github.com/Whiteknight/parrot-container'),
        :inst_lib([])
    );

    my @action_files := <
        ParrotContainer
        action/Action
        action/ActionArg
    >;
    setup_lib(%pc, "parrot_container_action.pbc", @action_files);

    my @container_files := <
        container/Container
        container/ItemBuilder
        container/Setup
    >;
    setup_lib(%pc, "parrot_container.pbc", @container_files);

    my @event_files := <
        event/Setup
        event/Event
        event/EventManager
    >;
    setup_lib(%pc, "parrot_container_event.pbc", @event_files);

    my @proto_files := <
        ParrotContainer
        prototype/PrototypeManager
    >;
    setup_lib(%pc, "parrot_container_prototype.pbc", @proto_files);

    pir::shift(@argv);
    setup(@argv, %pc);
}

sub setup_lib(%pc, $name, @files) {
    my @pbcs := < >;
    for @files {
        my $path := $_;
        my $nqp_file := $path ~ '.nqp';
        my $pir_file := $path ~ '.pir';
        my $pbc_file := $path ~ '.pbc';
        %pc<pir_nqp-rx>{$pir_file} := $nqp_file;
        %pc<pbc_pir>{$pbc_file} := $pir_file;
        @pbcs.push($pbc_file);
    }
    %pc<pbc_pbc>{$name} := @pbcs;
    pir::push(%pc<inst_lib>, $name);
}
