---
layout: rosella
title: Rosella Test
---

Here's basic code to create a test harness using Rosella Harness with NQP:

    INIT {
        pir::load_bytecode("rosella/tap_harness.pbc");
    }

    # Create your Harness, your View, and a Factory for creating TestRuns
    my $harness  := Rosella::build(Rosella::Harness);
    my $testview := $harness.default_view();
    my $factory  := Rosella::build(Rosella::Harness::TestRunFactory);

    # Add all test files from the "t/" directory, searching recursively
    # Add all test files to a default test run. Test files are presumed to be
    # written in NQP also.
    $factory.add_test_dirs("NQP", "t", :recurse(1));
    my $testrun := $factory.create();

    # Add the run to the view, then run it in the harness
    $testview.add_run($testrun, 0);
    $harness.run($testrun, $testview);

    # Show the results to the user
    $testview.show_results();

Here's an example, creating a test harness which runs sanity tests first,
and only runs remaining tests if the first batch passes.

    INIT {
        pir::load_bytecode("rosella/tap_harness.pbc");
    }

    # Create your Harness, your View, and a Factory for creating TestRuns
    my $harness  := Rosella::build(Rosella::Harness);
    my $testview := $harness.default_view();
    my $factory  := Rosella::build(Rosella::Harness::TestRunFactory);

    # Get the sanity tests. Do not recurse automatically
    $factory.add_test_dirs("NQP", "t/sanity", :recurse(0));
    my $sanityrun := $factory.create();

    # Create the "real" test run from a few specific directories
    $factory.add_test_dirs("Winxed", "t/src", "t/pmc", "t/lib", :recurse(1));
    my $testrun := $factory.create();

    # Add the runs to the view
    $testview.add_run($sanityrun, 0);
    $testview.add_run($testrun, 0);

    if ($harness.run($sanityrun, $testview))
        $harness.run($testrun, $testview)

    # Show the results to the user
    $testview.show_results();
