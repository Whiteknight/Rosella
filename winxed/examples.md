---
layout: winxed
title: Winxed and Parrot
---

Here we are going to show some code examples of small utility programs written
using Rosella:

### ls Clone

The Unix `ls` utility is used to show the contents of a directory. This example
uses the Rosella FileSystem library  and the Directory class to get the
directory contents:

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


