---
layout: winxed
title: Winxed and Parrot
---

Here we are going to show some code examples of small utility programs written
using Rosella:

### ls Clone

The Unix `ls` utility is used to show the contents of a directory. This example
uses several pieces of Rosella. The FileSystem's Directory type is used to read
the directory contents. The Stream class from the Query library is used to
iterate over all the directory contents and perform a variety of operations on
each to produce the final formatted output.

This example currently acts like the command "`ls -a`" by showing all items
including hidden files and folders. It does not support other common arguments
such as "`-l`".

{% highlight javascript linenos %}
{% include ls.winxed %}
{% endhighlight %}

### nl Clone

The Unix `nl` utility is used to print the contents of a file with line numbers.
The `-a` and `-t` options change the behavior to print some or all line numbers.
This example uses the Rosella FileSystem library and the File class to get the
file contents:

{% highlight javascript linenos %}
{% include nl.winxed %}
{% endhighlight %}


