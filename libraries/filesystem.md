---
layout: rosella
title: Rosella FileSystem
---

## Overview

Parrot provides a scant handful of utilities and routines for working with
items on the filesystem. These utilities tend to be thin wrappers around
lower-level system calls, and don't offer much in terms of ease-of-use or
consistency.

The Rosella FileSystem library provides Object-Oriented interfaces for dealing
with files and directories in the local filesystem.

## Concepts

## Namespaces

### Rosella.FileSystem

The `Rosella.FileSystem` namespace contains a random assortment of helper
methods and routines for working with files.

## Classes

### FileSystem.Entry

`Rosella.FileSystem.Entry` is an abstract base class for items which appear
in a file system. The main items are files and directories. Entries have some
common methods: `rename`, `delete`, `exists` and `short_name`.

### FileSystem.File

`Rosella.FileSystem.File` is an object that represents a file on the file
system. A File object is created with the name of the file to represent. This
name cannot be changed through the life of the File object unless the
underlying file is renamed.

The File class gives access to some basic IO routines, and includes some
utilities for automatically creating and opening a FileHandle. It also has
several routines for working with files, such as the interface for Entry
discussed above.

    var file = new Rosella.FileSystem.File("bar.txt");
    int exists = file.exists();
    string name = file.short_name();
    file.rename("foo.txt");
    file.write_all_text("This is text");
    string txt = file.read_all_text();
    file.delete();

### FileSystem.Directory

`Rosella.FileSystem.Directory` is an Entry object that represents a directory
in the file system. Directories contain lists of Files and Directories, which
can be read in and iterated over with `walk` routines.

    var dir = new Rosella.FileSystem.Directory("foo");
    dir.delete();               # Fails if the dir contains anything
    dir.delete_recursive();
    dir.rename("bar");
    int exists = dir.exists();
    var files = dir.get_files();
    var dirs = dir.get_subdirectories();
    var contents = dir.walk();
    dir.walk_func(function(var f) { say("File: " + string(f)); });

### FileSystem.Visitor

The contents of a directory and subdirectories can be recursively iterated
with a `Rosella.FileSystem.Visitor`. This is an abstract base class that
provides a common API for visitor types.

### FileSystem.Visitor.Delete

`Rosella.FileSystem.Visitor.Delete` is a Visitor type which is used to
recursively delete items in a directory. This is used to implement the
`Directory.delete_recursive` method.

### FileSystem.Visitor.Function

`Rosella.FileSystem.Visitor.Function` is used to execute an arbitrary
function reference on each File in the directory.

### FileSystem.Visitor.List

`Rosella.FileSystem.Visitor.List` reads a list of all directory contents
recursively and returns that list to the caller.

## Examples

### Winxed

### NQP-rx

## Users
