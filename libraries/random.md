---
layout: rosella
title: Rosella Random
---

## Overview

The Rosella Random library provides tools for generating and using random
numbers.

## Concepts

### Pseudo-Random Numbers

The Rosella Random library contains several utilities for generating
pseudo-random numbers. We use the word "pseudo" because even though the
generated number sequence appears to be random and subsequent numbers appear to
be unrelated there is still a fixed relationship. Pseudo-random number
generators (PRNG) will generate the same exact sequence of numbers given the
same starting conditions and internal state.

PRNGs work best by *seeding*. You provide a unique number or *source of entropy*
to the PRNG before generating any numbers to start the internal state from a
position that cannot be guessed easily. If properly seeded, you should get a
sequence from your PRNG that is apparently random and mostly unique.

## Namespaces

### Rosella.Random

The Rosella.Random namespace provides a series of utilities for working with
random numbers.

    // Get a default uniform distribution number generator
    var prng = Rosella.Random.default_uniform_random()

    // Get a default normal distribution number generator
    prng = Rosella.Random.default_normal_random()

    // Shuffle the array contents randomly
    Rosella.Random.shuffle_array([1, 2, 3, 4, 5]);

## Classes

### Random.RandomNumber

Abstract parent class of pseudo-random number generators. This class provides
the basic interface for PRNGs. Do not use this class directly, use a subclass
instead.

### Random.RandomNumber.MersenneTwister

An implementation of the Mersenne Twister algorithm. It is a generator of
uniformly-distributed random numbers.

### Random.RandomNumber.BoxMullerNormal

An implementation of the Box-Muller transform. It is a generator of
normally-distributed random numbers.

## Examples

### Winxed

This program uses the random library to generate and print two histograms: one
for the uniform distribution and one for the normal distribution:

    function main[main]()
    {
        var rosella = load_packfile("rosella/core.pbc");
        var(Rosella.initialize_rosella)("random");

        var rnd = Rosella.Random.default_uniform_random();
        print("\nHistogram of 500 uniformly-distributed floats: ");
        int buckets_a[] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        for (int i = 0; i < 500; i++) {
            int idx = rnd.get_range(0, 21);
            if (idx >= 0 && idx < elements(buckets_a))
                buckets_a[idx] = buckets_a[idx] + 1;
        }

        rnd = Rosella.Random.default_normal_random(10.00, 3.00);
        print("\nHistogram of 500 normal-distributed floats: ");
        int buckets[] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        for (int i = 0; i < 500; i++) {
            float value = rnd.get_float() + 0.5;
            ${ floor value, value };
            int idx = int(value);
            if (idx >= 0 && idx < elements(buckets))
                buckets[idx] = buckets[idx] + 1;
        }
    }

    function print_histogram(var buckets)
    {
        for (int i = 0; i < elements(buckets); i++) {
            print(i, ": ");
            for (int j = 0; j < int(buckets[i]); j++)
                print("#");
            say("");
        }
    }

### NQP-rx

## Users

The Rosella Query library uses the Random library for the .shuffle() method
