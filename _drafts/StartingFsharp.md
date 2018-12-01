# Starting F\#

Perhaps the simplest way to say what the programming language _F#_ is, is by analogy

>    _F#_ is to _Ocaml_ as _C#_ is to _java_

In short, its a functional language derived from _Ocaml_ built for the _.NET_ framework. 

## Getting started

Sometimes the hardest thing is just getting set up.

The O'Reilly book " " is a gentle introduction to the theory, but it's advice on getting started and installations is dated.  See **www.fsharp.org** for detailed advice.  I suggest for an IDE on _Windows_ using _Visual Studio Code_.

On Windows _F#_ binaries are installed as an option with _Visual Studio_.  The location changes with the verision, for instance, with _Visual Studio 2017_, they reside in

> C:\Program Files (x86)\Microsoft Visual Studio\2017\<sku>\Common7\IDE\CommonExtensions\Microsoft\FSharp

Add this to your path if you'd like to run the `fsi` interpreter or `fsc` compiler from the command line.


## When a function and variable look the same

There are several ways to define functions - heck this is a _functional_ language! Functions are simply lambda expressions assigned to identifiers:

    let myfunc = fun x y ->  x + y

where `fun` is the lambda keyword, arguments are delineated by spaces, and `return` is implicit: The value of the function body (here `x + y`) is returned. 

But no one ever writes functions like this, and instead uses _F#_'s syntactic sugar to write

    let myfun x y = x + y

or even

    let ambiguous_fun = x

So function definitions can look identical to just variable assignments.

### Scope

This similarity may suggest one could define a "lazy" function, which
referred to variables whose values were defined after the function, then
referenced later when the function is evaluated.  For example in _python_
it's fair to do this:

    def addsome():
        return x + v

    x = 7
    v = 6
    print("addsome ",  addsome())

But the same in _F#_ is not valid:

    let addsome = x + v
    let x = 7
    let v = 6
    printfn "addsome %i"  addsome

**This violates _F#_'s strict scoping rules.** Any global variables referred to in a function must be assigned before referenced. But _F#_ allows extensions since as a _.NET_ language is has access to its full functionality. Here's how to fool _F#_, a the cost of compile time checking that strict scoping permits:

    let addsome = lazy (x + v)
    let x = 7
    let v = 6
    printfn "addsome %i"  (addsome.Force())

