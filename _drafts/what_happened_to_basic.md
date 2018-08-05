# What happened to __BASIC__?

BASIC, as the command line interpreter that taught a couple generations of programmers to program is no more. When Kemeny at Dartmouth College introduced `BASIC` in 1964, it was an interpreted, command line (not that there was anything else at the time) language with an integrated edit-debug-run environment, that could be learned in a day. It's that's your nostalgic view of `BASIC` you won't find a facsimile of it on modern computers. 

As adopted by Microsoft, the language, which was integral to their software, evolved along with the Windows operating system, adding the preface "visual" to its name along with incremental features, such as classes and methods, until it split with its past and crossed a watershed at the turn of the Millenium. That's when Microsoft replaced `BASIC` with a similarly named language, but with an entirely different system model called "`.NET`", that brought it into the fold by adding compatibility to Microsoft's other languages, notably their own `C-sharp`, a language intended as their universal systems language. The newly introduced `BASIC .NET` has extended functionality inherited from `C-sharp`, to the point where the differences are largely superficial. 

As a result of the split, there are three places to find "BASIC", all of which tradeoff more power for the cost of the elegant simplicity of its ancestor. 

## VISUAL BASIC.NET

Now that the common method for programming is done with a visual interface known as an "Integrated Development Environment" (IDE) that automates the software development process, the command line has become optional. Microsoft's _Visual Studio_ IDE has tools to build `VISUAL BASIC` applications and services with graphical interfaces, that run locally or on the web, taking advantage of the `.NET` framework, so the command line is out of the picture. 

## VBA (Visual Basic for Applications)

`BASIC` has a sweet spot as language for [programming extensions](https://msdn.microsoft.com/VBA/office-shared-vba/articles/getting-started-with-vba-in-office) 
to existing desktop applications. These are modules such as event handlers that get control, do something, then return to the application. Incorporated in Microsoft's Office products, VBA replaces their various macro languages with a common language and IDE. If there's a future for `BASIC` this is it. 

## An existing command line BASIC? 

There actually is a `VISUAL BASIC` _compiler_ `vbc.exe` in the current Windows `.NET` framework, but its not accessible from the command line unless configured by adding it's file location to the system `PATH` variable. Actually there are several versions of it, one with each of the framework versions on the computer. You can find it, for instance, in 

    c:\windows\system... bin\

Add this to the system `PATH` as mentioned to expose a command to convert `BASIC .NET` code to a command line application.  This reveals how compilation works, but it's unnecessary, since as mentioned, the same thing can be done simply using _Visual Studio_ which manages compilation for you without exposing the compiler.

## What Microsoft has done with BASIC

`BASIC .NET` and, in fact the entire `.NET` framework has been released in open source on `github` under the code name [roslyn](https://github.com/dotnet/roslyn). 
[Roslyn](https://blogs.msdn.microsoft.com/visualstudio/2011/10/19/introducing-the-microsoft-roslyn-ctp/) includes open source for versions of both `C-sharp` and `VISUAL BASIC`. So yes, the there still is a BASIC, but it's a far cry from its origins. 




