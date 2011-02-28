INIT {
    pir::load_bytecode('distutils.pbc');
}

sub new_hash(*%args) { %args; }

MAIN(pir::getinterp__P()[2]);

sub MAIN(@argv) {
    my %rosella := new_hash(
        :name('Rosella'),
        :abstract('Utilities Library for Parrot'),
        :authority('http://github.com/Whiteknight'),
        :copyright_holder('Andrew Whitworth'),
        :keywords(< test tap xunit event container dependency-injection >),
        :license_type('Artistic License 2.0'),
        :license_uri('http://www.perlfoundation.org/artistic_license_2_0' ),
        :checkout_uri('git://github.com/Whiteknight/rosella.git' ),
        :browser_uri('git://github.com/Whiteknight/rosella'),
        :project_uri('git://github.com/Whiteknight/rosella'),
        :inst_lib([])
    );
    if @argv[1] eq "test" { do_test(); }

    my @rosella_files := <
        core/Rosella
        core/Error
    >;
    setup_lib(%rosella, "rosella/core.pbc", @rosella_files);

    my @action_files := <
        include/Core
        action/Action
        action/ActionArg
    >;
    setup_lib(%rosella, "rosella/action.pbc", @action_files);

    my @container_files := <
        include/Core
        include/Action
        container/Container
        container/ItemBuilder
        container/ObjectFactory
    >;
    setup_lib(%rosella, "rosella/container.pbc", @container_files);

    my @event_files := <
        include/Core
        include/Action
        event/Event
        event/EventManager
    >;
    setup_lib(%rosella, "rosella/event.pbc", @event_files);

    my @proto_files := <
        include/Core
        prototype/Item
        prototype/Manager
    >;
    setup_lib(%rosella, "rosella/prototype.pbc", @proto_files);

    my @query_files := <
        include/Core
        query/Query
        query/Provider
        query/provider/Array
        query/provider/Hash
        query/Path
    >;
    setup_lib(%rosella, "rosella/query.pbc", @query_files);

    my @proxy_files := <
        include/Core
        proxy/Factory
        proxy/MethodProxy
    >;
    setup_lib(%rosella, "rosella/proxy.pbc", @proxy_files);

    my @test_files := <
        include/Core
        test/Builder
    >;
    setup_lib(%rosella, "rosella/test.pbc", @test_files);

    my @xunit_files := <
        include/Core
        include/Test
        xunit/Assertions
        xunit/Failure
        xunit/Listener
        xunit/Listener/TAP
        xunit/Loader
        xunit/Result
        xunit/Suite
        xunit/Testcase
        xunit/UnitTestFailure
    >;
    setup_lib(%rosella, "rosella/xunit.pbc", @xunit_files);

    my @mockobject_files := <
        include/Core
        mockobject/Antiphon
        mockobject/Cuckoo
        mockobject/Cuculus
        mockobject/MockFS
        mockobject/Ovum
        mockobject/SigMatcher
        mockobject/Verifier
    >;
    setup_lib(%rosella, "rosella/mockobject.pbc", @mockobject_files);

    my @tap_harness_files := <
        include/Core
        tap_harness/Harness
        tap_harness/Line
        tap_harness/Loader
        tap_harness/Output
        tap_harness/TestFile
    >;
    setup_lib(%rosella, "rosella/tap_harness.pbc", @tap_harness_files);


    pir::shift(@argv);
    setup(@argv, %rosella);
}

sub setup_lib(%rosella, $name, @files) {
    my @pbcs := < >;
    for @files {
        my $path := $_;
        my $nqp_file := $path ~ '.nqp';
        my $pir_file := $path ~ '.pir';
        my $pbc_file := $path ~ '.pbc';
        %rosella<pir_nqp-rx>{$pir_file} := $nqp_file;
        %rosella<pbc_pir>{$pbc_file} := $pir_file;
        @pbcs.push($pbc_file);
    }
    %rosella<pbc_pbc>{$name} := @pbcs;
    pir::push(%rosella<inst_lib>, $name);
}

sub do_test() {
    my $nqp := get_nqp();
    my $result := pir::spawnw__IS($nqp ~ " t/harness");
    pir::exit(+$result);
}
