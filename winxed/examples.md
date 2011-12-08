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


### Lucas Number Recursive function

    #! winxed

    function lucas_number(int num)
    {
        if (num == 0) return 2;
        if (num == 1) return 1;
        return lucas_number(num-1) + lucas_number(num-2);
    }

    function main()
    {
        var stdin = getstdin();
        int num = stdin.readline();
        int result = lucas_number(num);
        say(result);
    }

### Lucas Number Closed Formula

    #! winxed
    $loadlib "trans_ops";

    function closed_formula(int num)
    {
        float result;
        float golden_ratio = 1.618;

        result = 1 - golden_ratio;
        ${ pow result, result, num };
        ${ pow golden_ratio, golden_ratio, num };
        result = golden_ratio + result;
        return result;      
    }

    function roundUp(float num)
    {
        int result = num;
        if (num >= (result + 0.5)) 
            return (result + 1);
        else 
            return result;
    }

    function main()
    {
        var stdin = getstdin();
        int num = stdin.readline();
        float result = closed_formula(num);
        result = roundUp(result);
        say(result);
    }

### Generalized Fibonacci Sequence

    #! winxed

    function generate_Fibonacci_sequence(int r0, int r1)
    {
        var f = function (int num) 
        {
            if (num == 0 ) return r0;
                if (num == 1)  return r1;
            return f(num-1) + f(num-2);
        };
        return f;
    }

    function main()
    {
        var stdin = getstdin();
        int r0 = stdin.readline();
        int r1 = stdin.readline();
        generate_Fibonacci_sequence(r0, r1);
    }
    
### Gaussian Prime

    #! winxed
    $loadlib "trans_ops";

    function is_gaussian_prime(int a, int b)
    {
        int power = 2;
        a = pow(a, power);
        b = pow(b, power);
        int gaussian_number = a + b;
        int result = is_normal_prime(gaussian_number);
        if ( result == 1)
            return 1;
        else 
            return 0;
    }

    function pow(int a, int power)
    {
        float f_a = float(a); 
        float result;
        ${ pow result, f_a, power };
        return int(result);
    }
    
    function is_normal_prime(int num)
    {
        for(int mod = 2; mod <= (num/2); mod++)
        {
            if (num % mod == 0)
                return 0;
        }
        return 1;    
    }
    
    function main() 
    {
        var stdin = getstdin();
        int a = stdin.readline();
        int b = stdin.readline();
        int result = is_gaussian_prime(a, b);
        if (result == 1)
            say(a, " + ", b, "*i is Gaussian Prime");
        else 
            say(a, " + ", b, "*i is not Gaussian Prime");
    }

### String inside other string

    #! winxed

    function check_for_searcher_string(string container, string searcher)
    {   
        int checker = 0;
        int counter = length(container);
        int search_count = length(searcher);
        string container_char;
        string search_char;
        say(counter);
        say(search_count);
        for (int index = 0; index < counter; index++)
        {
            if (checker != search_count && checker != (search_count-1))
            {
                container_char = substr(container, index, 1);
                search_char = substr(searcher, checker ,1);
                    if (search_char == container_char)
                    checker++;
                else
                {
                    if (checker != 0)
                    {
                        checker++;
                        search_char = substr(searcher, checker ,1);
                        if (search_char != container_char)
                            checker = checker - 2;
                    }
                }
            }
        }
        if ((checker == search_count) || (checker == search_count-1))
            return 1;
        else 
            return 0;
    }   

    function main()
    {
        var stdin = getstdin();
        say("Enter Container String");
        string container_string = stdin.readline();
        say("Enter Searcher String");
        string searcher_string = stdin.readline();
        int result = check_for_searcher_string(container_string, searcher_string);
        if (result == 1)
            say("Searcher String is contained within Container String");
        else 
            say("Searcher String is not contained within Container String");
    }
    

