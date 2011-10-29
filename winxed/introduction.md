---
layout: winxed
title: Introduction
---

## Get Winxed

Winxed is snapshotted into the Parrot development repository and is included
in all Parrot releases

### Plumage

### With Parrot

### Get the Source

## Building and Running Winxed

Run a file directly:

    winxed myfile.winxed

Compile a file to PIR and PBC:

    winxed -c -o myfile.pir myfile.winxed
    parrot -o myfile.pbc myfile.pir
