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

## Classes

### FileSystem.File

`Rosella.FileSystem.File` is an object that represents a file on the file
system. A File object is created with the name of the file to represent. This
name cannot be changed through the life of the File object unless the
underlying file is renamed.

### FileSystem.Directory

### FileSystem.Visitor

### FileSystem.Visitor.Delete

### FileSystem.Visitor.Function

### FileSystem.Visitor.List

## Examples

### Winxed

### NQP-rx

## Users
