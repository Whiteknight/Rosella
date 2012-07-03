---
layout: rosella
title: Rosella Xml
---

## Overview

The Rosella Xml library is used to read and write data in XML markup format.

## Concepts

## Namespaces

### Rosella.Xml

The `Rosella.Xml` namespace contains some important driver routines for parsing
existing XML documents.

* `read_string`: Read a string of XML and return an Xml.Document
* `read_file`:  Read XML from a file. Return an Xml.Document
* `read_dtd_string`: Read a DTD document from a string
* `read_dtd_file`: Read a DTD document from a file

### Rosella.Xml.Tag

* `child_tag_finder_name_attrs`:
* `child_tag_finder_attrs`:

## Classes

### Rosella.Xml.Document

`Rosella.Xml.Document` is an object representing an entire XML document. It
contains the entity information along with headers and other metadata.
Documents can be created from parsing a string of existing XML markup or by
creating it directly.

### Rosella.Xml.DtdDocument

`Rosella.Xml.DtdDocument` represents a DTD document. It can be created from
parsing a DTD definition, by parsing an XML document with DTD information
included inline, or by creating it directly.

### Rosella.Xml.Tag

`Rosella.Xml.Tag` represents a complete XML tag, including attributes and
child contents.

### Rosella.Xml.Tag.EndTag

An end tag </foo>

### Rosella.Xml.Tag.XmlHeader

`Rosella.Xml.Tag.XmlHeader` represents an `<?xml ... ?>` tag at the beginning
of the document, typically with version or encoding information.

### Rosella.Xml.Tag.DtdHeader

`Rosella.Xml.Tag.DtdHeader` represents a `<!DOCTYPE ...?>` tag at the beginning
of the document with schema information.

### Rosella.Xml.Tag.DtdElement

`Rosella.Xml.Tag.DtdElement` represents an `<!ELEMENT>` declaration in a DTD.

### Rosella.Xml.Tag.DtdAttlist

`Rosella.Xml.Tag.DtdAttlist` represents an `<!ATTLIST>` declaration in a DTD.

### Rosella.Xml.Tag.Comment

`Rosella.Xml.Tag.Comment` represents a `<!-- -->` Comment in XML

### Rosella.Xml.Tag.DocumentRoot

A helper class for the parser. Not for user applications.

### Rosella.Xml.Tag.Collection

`Rosella.Xml.Tag.Collection` represents a collection of Tag objects. It is an
Iterable type.

### Rosella.Xml.Text

`Rosella.Xml.Text' represents literal strings of text in the xml document.

### Rosella.Xml.Visitor

`Rosella.Xml.Visitor` implements a visitor pattern for algorithms that need to
visit and operate on all nodes in the document recursively.

### Rosella.Xml.Visitor.Lister

`Rosella.Xml.Visitor.Lister` is an example visitor type which creates a list of
all nodes in the document.

### Rosella.Xml.Visitor.DtdValidator

`Rosella.Xml.Visitor.DtdValidator` performs validation of an XML document
according to a given DTD document. It returns a flag for whether the document
passes validation, and a list of error messages if it does not.

## Winxed Include Files

## Examples

### Winxed

### NQP-rx

## Users
