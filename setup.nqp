INIT {
    pir::load_language('parrot');
    pir::load_bytecode('distutils.pbc');

    pir::load_bytecode('dumper.pir');
}

sub get_args() {
    my $interp := pir::getinterp__P();
    $interp[2];
}

sub new_hash(*%args) { %args; }

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

    my @xunit_files := <Assertions Listeners Loader Standalone Suite Testcase Result>;
    my @xunit_pbcs := < >;

    for @xunit_files {
        my $nqp_file := $_ ~ '.nqp';
        my $pir_file := $_ ~ '.pir';
        my $pbc_file := $_ ~ '.pbc';
        %parrot_test<pir_nqp-rx>{$pir_file} := $nqp_file;
        %parrot_test<pbc_pir>{$pbc_file} := $pir_file;
        @xunit_pbcs.push($pbc_file);
    }
    %parrot_test<pbc_pbc><parrot_test_xunit.pbc> := @xunit_pbcs;

    pir::shift(@argv);
    setup(@argv, %parrot_test);
}

