---
layout: rosella
title: Rosella FileSystem
---

## Overview

Parrot provides a scant handful of utilities and routines for working with
items on the filesystem, and most of these are available as extensions. These
utilities tend to be thin wrappers around lower-level system calls, and don't
offer much in terms of ease-of-use, higher-level semantics, or consistency.

The Rosella FileSystem library provides Object-Oriented interfaces for dealing
with files and directories in the local filesystem. The aim of this library
is to provide these capabilities through a usable, extendable, object-oriented
interface. This library operates as a wrapper around the `OS` dynpmc and the
other capabilities afforded by Parrot. Many behaviors, such as error
exceptions from the `OS` PMC are passed along to users of this library on
error.

## Concepts

## Namespaces

### Rosella.FileSystem

The `Rosella.FileSystem` namespace contains a random assortment of helper
methods and routines for working with files. Among these:

* `get_os_pmc()`: Get an instance of the underlying `OS` PMC which implements
  the low-level operations from Parrot.
* `set_os_pmc(os)`: Set the `OS` PMC instance used by the library to a custom
  object, such as a new `OS` or a custom subclass. This is used, for example,
  in the test suite to replace the default `OS` PMC with a mock object for
  testing without needing to create and play with files.
* `is_file(string)`: Determine if the given path points to an existing file.
* `is_directory(string)`: Determine if the given path points to an existing
  directory.

## Classes

### FileSystem.Entry

`Rosella.FileSystem.Entry` is an abstract base class for items which appear
in a file system. The main items are files and directories. Entries have some
common methods: `rename`, `delete`, `exists` and `short_name`. The `rename`
operation renames the file on disk and updates the path string stored in the
Entry object.

### FileSystem.File

`Rosella.FileSystem.File` is an object that represents a file on the file
system. A File object is created with the name of the file to represent. This
name cannot be changed through the life of the File object unless the
underlying file is renamed.

The File class gives access to some basic IO routines, and includes some
utilities for automatically creating and opening a FileHandle. It also has
several routines for working with files, such as the interface for Entry
discussed above.

Here are some example usages of File:

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

Here are some example usages of Directory:

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

Visitors are typically not used by the user directly. Instead, they are used
through the Directory `.walk()` and `.walk_func()` methods, and other methods
on the Directory object.

### FileSystem.Visitor.Delete

`Rosella.FileSystem.Visitor.Delete` is a Visitor type which is used to
recursively delete items in a directory. This is used to implement the
`Directory.delete_recursive` method. This visitor deletes all files in a
folder and then deletes the folder itself, during recursion.

### FileSystem.Visitor.Function

`Rosella.FileSystem.Visitor.Function` is used to execute an arbitrary
function reference on each File in the directory. It only executes functions
on the File entries, no the subdirectories.

### FileSystem.Visitor.List

`Rosella.FileSystem.Visitor.List` reads a list of all directory contents
recursively and returns that list to the caller.

## Examples

### Winxed

    var rosella = load_packfile("rosella/core.pbc");
    var(Rosella.initialize_rosella)("filesystem");

Create a new directory:

    var dir = construct(class Rosella.FileSystem.Directory, "foo");
    if (!dir.exists())
        dir.create();

Create a new file with some text:

    var file = construct(class Rosella.FileSystem.File, "foo.txt");
    file.write_all_text("This is text");

Get a file from the current directory:

    using Rosella.FileSystem.Directory.current_directory;
    var dir = current_directory();
    var file = dir["foo.txt"];
    string txt = file.read_all_text();

### NQP-rx

    my $rosella := pir::load_bytecode__ps("rosella/core.pbc");
    Rosella::initialize_rosella("filesystem");


## Users
