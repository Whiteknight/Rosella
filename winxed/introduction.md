---
layout: rosella
title: Introduction
---

## Building and Running Winxed

Run a file directly:

    winxed myfile.winxed

Compile a file to PIR and PBC:

    winxed -c -o myfile.pir myfile.winxed
    parrot -o myfile.pbc myfile.pir
