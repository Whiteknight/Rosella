INIT {
    pir::load_language('parrot');
    pir::load_bytecode('distutils.pbc');

    pir::load_bytecode('dumper.pir');
}

sub get_args() {
    my $interp := pir::getinterp__P();
    $interp[2];
}

MAIN(get_args());

sub MAIN(@argv) {
    my %parrot_test := new_hash(
        :name('Parrot-Test'),
        :abstract('Testing library for Parrot'),
        :authority('http://github.com/Whiteknight'),
        :copyright_holder('Andrew Whitworth and Austin Hastings'),
        #:doc_files(		<README CREDITS> ),
        :keywords(< xunit >),
        :license_type('Artistic License 2.0'),
        :license_uri('http://www.perlfoundation.org/artistic_license_2_0' ),
        :checkout_uri('git://github.com/Whiteknight/parrot-test.git' ),
        :browser_uri('git://github.com/Whiteknight/parrot-test'),
        :project_uri('git://github.com/Whiteknight/parrot-test'),

        #:harness_files(		pir::join(' ', <
        #    !t/test-data
        #    !t/Matchers/Tree.nqp
        #    !t/Pmc
        #    !t/Structure
        #    t
        #>) ),

        #:release_id(			'release-10' ),
        #:release_dir_format(	'released/%s'),
    );

    %parrot_test<pir_nqp-rx><Assertions.pir> := 'Assertions.nqp';
    %parrot_test<pir_nqp-rx><Listeners.pir> := 'Listeners.nqp';
    %parrot_test<pir_nqp-rx><Loader.pir> := 'Loader.nqp';
    %parrot_test<pir_nqp-rx><Standalone.pir> := 'Standalone.nqp';
    %parrot_test<pir_nqp-rx><Suite.pir> := 'Suite.nqp';
    %parrot_test<pir_nqp-rx><Testcase.pir> := 'Testcase.nqp';
    %parrot_test<pir_nqp-rx><Result.pir> := 'Result.nqp';

    %parrot_test<pbc_pir><parrot_xunit_test.pbc> := <
        Assertions.pir
        Listeners.pir
        Loader.pir
        Standalone.pir
        Suite.pir
        Testcase.pir
        Result.pir
    >;
    pir::shift(@argv);
    setup_(@argv, %kakapo);
}

