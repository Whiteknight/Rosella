---
layout: rosella
title: Rosella Random
---

## Overview

The Rosella Random library provides tools for generating and using random
numbers.

## Concepts

### Pseudo-Random Numbers

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

### NQP-rx

## Users

The Rosella Query library uses the Random library for the .shuffle() method
