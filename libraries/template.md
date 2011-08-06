---
layout: rosella
title: Rosella Template
---

## Overview

The Rosella Template library is a text-templating and string-formatting
library with configurable syntax and semantics. By specifying a text template
and a data context object, the templating engine can create output text.

## Concepts

### Templates

Templates are strings of text which contain both literal data and metadata.
During template rendering, an output string is created which contains the
literal data verbatim and generated output data is inserted in place of the
metadata. The result should be an expected output, clean of the logic which
was used to create it.

Templates are constructed using two components: The first is the string
literal which forms the template itself. The second is the data object which
is used to feed values and control into the template's metadata. This
separation of concerns is important. The template literal specifies exactly
what should be shown in the output and how. The data can change on each
usage to create distinct, if similar, outputs. The third component is the
rendering engine, the details of which are safely encapsulated from both the
template text and the input user data. This division of concerns is called
"Model View Controller" (MVC). In this case, the Model is the user data
context object, the view is the template, and the controller is the template
rendering engine, provided in the Rosella Template library.

### Data Context

The data context object is an object which is provided to the template which
contains user data. The provided user data is treated as read-only, but the
Context object which wraps it contains temporary storage locations to hold
edits and temporary values during rendering.

The user context object is typically a hash or a hash-like object. It is
searched using the Rosella Path library to find values and nested sub-values.
Any object which can be traversed with the Path library can be used as a
context object for rendering templates.

## Namespaces

## Rosella.Template

The Rosella.Template namespace contains a small number of support routines
to help with using templates. Rosella ships with a number of "standard"
templates, which can be easily accessed using the routines
`get_standard_template_file` and `get_standard_template_text`.

## Classes

### Template.Context

The `Rosella.Template.Context` object is a hash-like wrapper object around a
user context object. It provides access to the user data object and also
provides storage for temporary values. On value lookup, the context object
searches in the temporary storage first, and looks in the user data object
second. In this way, edits to existing keys can be made, while not actually
modifying the user data.

### Template.Engine

The `Rosella.Template.Engine` object is the primary user-visible interface to
the template rendering capabilities of the library. The engine brings together
the tools and data necessary, renders the template, and returns the output
to the user.

The Engine sets up the various sub-components to use a default set of syntax
and semantics for templates. Most of these components can be modified using
an API on the Engine object to change details about templates and rendering.

### Template.Node

The Engine object reads in the template text and parses it into a tree of
`Rosella.Template.Node` objects. Each Node represents a single bit of the
template, be it a string of literal text or a complicated logic node with
children. Node is an abstract parent class, all the interesting behaviors
happen in subclasses.

After parsing, the Engine traverses the tree of Nodes, calling the `render`
method on each to produce output. During rendering, each node writes its text
into a StringBuilder object, which is assembled into a String at the end.

### Template.Node.Data

`Rosella.Template.Node.Data` nodes are simple lookups into the Context. When
a Data Node is rendered, it looks up the argument in the Context, and outputs
the value verbatim into the StringBuilder.

The default syntax for the Data node uses `<# #>` markers. Here's an example
of a Data region in a template using this default syntax:

    The cow says: "<# foo.bar.baz #>"

If we have the following data context object:

    var ctx = { "foo" : { "bar" : { "baz" : "Mooo!" } } };

The output which will be rendered is: `The cow says: "Mooo!"`.

### Template.Node.Eval

`Rosella.Template.Node.Eval` nodes take string literals of executable code. By
default, the code recognized is Winxed, though this is configurable. During
rendering, the Eval node compiles the code into an executable subroutine, and
executes it. The output from that subroutine is inserted into the buffer.

The default syntax for the Eval node uses `<% %>` markers. Here's an example
of an Eval region in a template, using this default syntax:

    The cow says: "<% return "Hello world!"; %>"

This snippet will render in the output as `The cow says: "Hello world!"`.

### Template.Node.Factory

The `Rosella.Template.Node.Factory` is used to create nodes, using a lookup
map provided to it by the Engine. The nodes created by the node Factory can be
modified by calling appropriate methods on the Engine.

### Template.Node.Literal

`Rosella.Template.Node.Literal` nodes are literal text which is not influenced
by metadata. The text of the literal is output verbatim into the buffer. All
text outside of specially configured tagged regions is literal text.

### Template.Node.Logic

`Rosella.Template.Node.Logic` nodes implement various behaviors. Every logic
node type has a name, and that name is used to look up a suitable Handler
object. The Logic node is a thin placeholding wrapper around the individual
Handler, which controls the way surrounding text is parsed and how the node
is rendered.

Some logic nodes, such as a `for` loop contain child nodes. The Logic node and
its Handler determine how the children, or inner, nodes are rendered. In these
cases where the Logic node has children, it will be accompanied by an `end`
node. For instance, the Logic node `<$ for x in y $>` would have several
child nodes followed by a `<$ endfor $>` node. Here's an example:

    <$ for x in y $>
    This is literal text and will be repeated verbatim
    This is the current value of x: <# x #>
    <$ endfor $>

### Template.Node.Master

The `Rosella.Template.Node.Master` node is the top-level node which represents
the template as a whole. It is used to indicate the top of the parse tree and
to recursively render the rest of the nodes in the parse tree.

### Template.Handler

`Rosella.Template.Handler` objects provide behavior for Logic nodes. Each
handler does different things, but from the point of view of the Engine they
all have the syntax of Logic nodes and are treated uniformly. Handler is an
abstract parent class which defines the interface for all handlers. Do not use
this type directly, use a subclass instead.

### Template.Handler.Children

`Rosella.Template.Handler.Children` is the parent class of most node types
which have children. `for` and `repeat` loops, for instance, are subclasses
of the Children handler. Some types, such as `if/else` blocks need more
complicated management logic and do not descent from Children.

This is also an abstract parent type and should not be used directly.

### Template.Handler.Factory

### Template.Handler.For

`Rosella.Template.Handler.For` performs a `for` loop over an aggregate. On
each iteration of the loop it defines three variables: `__FIRST__` is 1 on
the first iteration of the loop only, 0 otherwise. `__LAST__` is 1 on the
final iteration of the loop only, 0 otherwise. If iterating over a hash, the
special variable `__KEY__` will contain the string key.

### Template.Handler.If

### Template.Handler.Include

### Template.Handler.Repeat

### Template.Handler.Set

### Template.Handler.Unless

`Rosella.Template.Handler.Unless` is identical to the `if` handler in all ways
except it reverses the logical condition. Unless with an `else` clause is
identical to an `if` with an `else` clause except the ordering of the two
clauses is reversed.

    <$ if x $>
        This is printed if true
    <$ else $>
        This is printed if false
    <$ endif $>

    <$ unless x $>
        This is printed if false
    <$ else $>
        This is printed if true
    <$ endunless $>

If the `else` clause is ommitted, the `unless` handler operates like an exact
opposite of the `if` handler.

## Examples

### Winxed

Rendering a template with Winxed is easy. The real complications come in the
syntax for defining templates.

    var engine = new Rosella.Template.Engine();
    string output = engine.generate(template, context);

### NQP

    my $engine := Rosella::construct(Rosella::Template::Engine);
    my $output := $engine.generate: $template, $context;

### Templates

Here is a `for` loop, using special loop control variables to construct an
snippet of code for an array literal:

    <$ for x in y $>
        <$ if __FIRST__ $>[<$ endif $>
            <# x #> <$ unless __LAST__ $>,
        <$ else $>];<$ endif $>
    <$ endfor $>

Given this context:

    var ctx = { "y" : [1, 2, 3, 4] };

...would produce this output:

    [
        1,
        2,
        3,
        4
    ];

## Users

* Rosella has several utility programs which use the template library to
automatically generate files and code snippets, such as unit tests and test
harnesses.
