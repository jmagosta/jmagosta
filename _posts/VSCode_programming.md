---
title: "Programming in _VS Code_"
author: "John Mark Agosta"
date: "January 12, 2019"
output: 
  html_document:
  theme: journal
---

As a python programmer I'd like to share the pleasantly productive time I've had getting up to speed into programming on Windows. 
The steepest learning curve for programming can be setting up and learning one's way around the development environment. [Visual Studio Code](https://code.visualstudio.com/) is a recent, lightweight universal programming editor. This article recommends it for programming in C#, F#, and python.

The _VS Code_ editor has downloadable _extensions_ for most all languages, but does not include toolchain environments for them. This article describes setting up toolchains for development, for both Microsoft's "Common Language Runtime" (CLR) languages, and for _python,_ which does not use CLR. What _VS Code_ gives you is interactive and compiled execution, debugging, intellisense, versioning integration, and a convenient file-directory based project structure.  

The [Visual Studio Code](https://code.visualstudio.com/) editor replaces many development tasks that required the conventional Visual Studio IDE with a lighter-weight implementation, and wider applicability across platforms (e.g Mac OS, Ubuntu) and languages. A new set of libraries for CLR managed code, the `.net Core` framework integrates with it, and they are also available cross platform. It's on its way to becoming the go-to IDE for runtime languages such as C# and F#, and plays well with open source scripting languages such as _python._ This article notes some of the finer, not-so-obvious setup and configuration steps for getting to "Hello World" in these three languages.

## Getting `dotNet`

For languages that run on Microsoft's CLR, the libraries and tools for the environment must be installed separately from _VS Code._  It's recommended to use  the `.net Core` libraries and utilities. You can get it from the [the`.NET Core` website](https://dotnet.microsoft.com/download) to install the `dotnet` command. The website states ".NET Core is a cross-platform version of .NET for building websites, services, and console apps." Think of it as the equivalent to `gcc` for C# and related .NET languages, but with "batteries included."

## Building and Running C# 

`.NET Core` supports development from either the command line, or within the _VS Code_ editor, but the process differs. Either way one needs to start by creating CLR language projects with the `dotnet` command. 
The command line version includes these commands (each prefaced with `dotnet`):

    add
    new
    restore
    run
    build
    test
    publish

### Setting up a project

`dotnet` presumes you'll set up your project with the `dotnet new` command before you start writing code. 

    dotnet new console -o myprojfolder

This creates a new folder `myprojfolder` with a code stub called `Program.cs` for you, along with the config `myprojfolder.csjson` file named after your project. You can rename or replace the code stub and the project will include it. But you do need the project file to build your app.  Don't mix dotnet projects with conventional Visual Studio projects, by combining the project file from the Visual Studio IDE project folder.  _VS Code_ will read the file and get confused. _VS Code_ assumes there is only one project in the project folder.  



### Project structure

As said, both the new project folder and the`.csproj` file, are named after the project. A newly created project also holds a `obj` directory. All code files in the folder are assumed part of the project. Thus the file name of the code file in the project containing the program entry point is irrelevant. This project structure is different and not compatible with conventional Visual Studio projects.

The `.csproj` file is used to initiate the build for whatever `.cs` files are present in the same directory, when no files are referenced explicitly in the file.

### Building and running from the command line.

But if you want to run from the command line, the steps in the toolchain are `dotnet restore`, then `dotnet build` (e.g. compile), finally `dotnet run`, which incidentally will execute both previous steps if not already executed. Note you don't need to give the program name to be executed, but `dotnet run` does take your program command line arguments. `dotnet` commands assume you have internet access, and will download any system components a command needs while executing.

### Building and running in _VS Code_.

The two files that control execution in _VS Code_ (but apparently not from the cmd line) are

    .vscode\tasks.json
    .vscode\launch.json

 _VS Code_'s Debug menu commands debug and run your code by referring to the `tasks.json` and `launch.json` contents. This hides much of the build detail for you. Debugging is where this editor shines, and not just for CLR languages.  

These "assets" are created the first time the project is run, and reside in the project's `.vscode` folder. 

`tasks.json` specifies the `build` command for the project. Unless you want to customize the build process you don't need to change this.  The build process also can be specified manually with the `dotnet build` command. 

`launch.json` specifies configurations, which the build command uses for example for debugging configuration. "Launch" implies running within the editor, rather than as a separate process "attached" to the debugger. "Open Configurations" in the debug menu will display this file.

Two fields one may need to set are
1) Command line arguments; an array of strings assigned to the `args` parameter in `Main()`:

    "args": ["route", "66"],

2) Where the console output appears.  It defaults to "internalConsole" so program output appears in _VS Code_ 's Debug Console.  Instead, if you want an Terminal console, so the program can pause and accept terminal input from `Console.ReadKey()`,  set it to

    "console": "integratedTerminal",

to avoid getting the error: "Cannot read keys when either application does not have a console."  Input and output will appear in the editor's Terminal console. Note that neither of these fields apply when invoking your program from the command line. 

### Creating an executable

Even though your can execute your code with the `dotnet run` command, to "publish" it, that is to create a stand-alone executable you need additional steps. As example of the publish command is

    dotnet publish -c release --self-contained -r win-x64

where `win-x64` is an example of a "TargetFramwork". The results will reside in a folder under `bin\release\netcoreapp2.2\win-x64\` with the application contents. Full details on publishing and installing applications are beyond the scope of this article.

#### An Aside: dotNet core and MSBuild

`dotnet` provides syntactic sugar for running `MSBuild`, ---think `make` from the Unix world. 
MSBuild for `.NET Core` is new. Not surprisingly there is a `dotnet msbuild` command equivalent for `MSBuild.exe`
that can be invoked directly to execute tasks, which is good since 
installing dotnet does not put MSBuild in your path. `dotnet build` is equivalent to `dotnet msbuild -restore -target:Build`. There is hidden from normal view a detailed build process (what MSBuild actually inputs) that can be inspected by generating its XML project file. 

#### Another example: Creating a local web app

As a matter of interest `.NET Core` can create several kinds of projects. For instance, the dotnet command line for a web app is

    dotnet new mvc -au None -o mywebapp

It will serve to `localhost:5000`

### Steps to configuring projects in VS Code that require downloaded packages

VSCode is good about anticipating build properties your code needs without you needing to edit config (e.g. `.*proj`) files. For example, see [Math.NET](https://numerics.mathdotnet.com) 
for the equivalent of python's `numpy` libraries.  But you do need to tell dotnet to download them.  While doing this `dotnet` automatically places package references to them in the project file.  
The commands to do this are

    dotnet add package MathNet.Numerics

The package will be recognized and pulled down by the "Nuget" package manager---think `pip` for .NET.

As an aside, I've been working with [`infer.net`](https://dotnet.github.io/infer/) an open-sourced probabilistic programming framework that requires its own libraries available via Nuget: 

    dotnet add package Microsoft.ML.Probabilistic

## Three ways to setup F#, an example of another CLR language.

### 1. With the `dotnet` command

Start as you would with C#, creating a project from the command line

    dotnet new console --language F# -o myFsharpProject

that you can run, as before with `dotnet run.` 

### 2. In _VS Code_

Or you can set up _VS Code_ to run F#. As before _VS Code_ alone will not run the project, since the
`launch.json` and `task.json` files need to be set up. The "Ionide-fsharp" extension has commands that can assist; find it in _VS Code_'s extensions pane. But if you then just attempt to run an F# project you've created with `dotnet new` it complains "cannot find the task build".  So go ahead and select the error alert's "Configure Task" option. It will suggest the command "Create tasks.json file from template" then suggest a template.  Choose ".NET Core", then complete the `launch.json` file by replacing the placeholders for the project (not the .fs file) name, and the target-framework, which can be found from the `.csproj` file. Now you can run your code using the _VS Code_ Debug menu. As with other languages, with the default
"InternalConsole" setting in `launch.json`, printout goes to _VS Code_'s "Debug Console". 

### 3. Using command line binaries

There's a third way to run F#, using the Windows stand-alone binaries. 
There are two kinds of F# source files, each run in different ways; script files with a `.fsx` suffix, run interactively and `.fs` files contained in a project that can be compiled.  To compile F# you will need to install the "Build Tools for Visual Studio 2017" from the Visual Studio IDE. (Yes, in this case you need to have installed Visual Studio.) Select just "Individual Components, F# Compiler". This installs the Fsharp compiler `fsx`, F# interpreter `fsi`, along with `msbuild`. Similarly you'll find the C# compiler `csc` and interpreter `csi`.  They appear under `C:\Program Files (x86)\Microsoft Visual Studio\2017\..`  or `C:\Program Files (x86)\Microsoft SDKs\..` However vanilla _cmd_ terminal will _not_ have them in your path. To find them, launch a _cmd_ variant from the _Start_ menu, such as "x86 Native Tools Command Prompt..", which will include it `%PATH%` the multitude of paths to these tools. By the way command line binaries are another way to generate stand-alone executables. 

# Setting up Python in _VS Code_.

Jupyter notebooks may be unsurpassed for data exploration and visualization, but _VS Code_ is arguably the best python source code debugger short of one of the dedicated python IDEs, especially once your project includes multiple files. And moreover _VS Code_ has no shortcomings with visualization, since the python `bokeh` package will show graphics by opening them in browser tabs when not called from Jupyter. 

_VS Code_ will remind you to install the "Python extension for VS Code" once it recognizes the python file type. Next it will ask you to select one of your existing python environments. Get to know the shortcut "cntl-shift-P", where commands like "Python: Select Interpreter" can be found.  The list of environments that can be activated comprises both those hidden in Visual Studio tools directories, and, cleverly, the individual conda environments. But the bash shell (e.g. "Windows Subsystem for Linux") is one place where _VS Code_ can't run python, since it doesn't look there for python interpreters.  Be relieved that running with the Anaconda install for Windows is arguably just as good. 

Actually when you set the environment, you are modifying the project's settings file, something which can also be done manually, in the user version of `settings.json` found in the `.vscode` subfolder. Inexplicably this is not possible with _VS Code_'s settings option, found under the "File" menu.

 Note that running interpreted code did not require a `launch.json` or `task.json` file. Running code simply inserts the call at the command line in the terminal window, where you can recall it, or modify it. But if you have command line arguments, you will need to create a `launch.json` file ("Open Configurations" from the debug menu will create one), and insert a line like this in the "Python Current File .." configuration section:

    "args": ["-a", "\"quoted string\"", "6"],

These values will be used for both "debug" and "without debug" run options. Note that there is no project file for python projects. 

## Other sources

In summary, _VS Code_ easily configures to run pretty much any language.  Many more customizations and features exist that are documented online. Have a look at the usual suspects in [Microsoft Docs](https://code.visualstudio.com/docs) and [StackOverFlow](https://stackoverflow.com/).


 



