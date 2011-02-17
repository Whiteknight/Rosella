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

    my @xunit_files := <
        xunit/Assertions
        xunit/Listener
        xunit/Listener/TAP
        xunit/Loader
        xunit/Result
        xunit/Suite
        xunit/Testcase
        xunit/UnitTestFailure
    >;
    my @xunit_pbcs := setup_lib(%parrot_test, "parrot_test_xunit.pbc", @xunit_files);

    my @mockobject_files := <
        mockobject/Setup
        mockobject/Antiphon
        mockobject/Cuckoo
        mockobject/Cuculus
        mockobject/MockFS
        mockobject/Ovum
        mockobject/SigMatcher
        mockobject/Verifier
    >;
    my @mockobject_pbcs := setup_lib(%parrot_test, "parrot_test_mockobject.pbc", @mockobject_files);

    my @tap_harness_files := <
        tap_harness/Harness
        tap_harness/Line
        tap_harness/Loader
        tap_harness/Output
        tap_harness/TestFile
    >;
    my @tap_harness_pbcs := setup_lib(%parrot_test, "parrot_test_tap_harness.pbc", @tap_harness_files);


    %parrot_test<inst_lib> := < >;

    pir::shift(@argv);
    setup(@argv, %parrot_test);
}

sub setup_lib(%parrot_test, $lib, @files) {
    my @pbcs := < >;
    for @files {
        my $path := $_;
        my $nqp_file := $path ~ '.nqp';
        my $pir_file := $path ~ '.pir';
        my $pbc_file := $path ~ '.pbc';
        %parrot_test<pir_nqp-rx>{$pir_file} := $nqp_file;
        %parrot_test<pbc_pir>{$pbc_file} := $pir_file;
        @pbcs.push($pbc_file);
    }
    %parrot_test<pbc_pbc>{$lib} := @pbcs;
}
