---
title: We built this blog on Jekyll and GitHub
layout: post
---

# Setting up static websites hosted by *Github*, with *Jekyll*

Yes that's a mouth-full, but it describes the shortest path to setting up a blog for the modestly code-savvy blogger.
[Jekyll](http://http://jekyllrb.com/docs) is the simplest of all content management systems for building a website.
Github, if you are familiar with it as a code-sharing repository, incidentally also serves webpages. Think of
the ```README.md``` file that *GitHub* shows for each respository. So as a sideline, they've created a way for one to serve a directory with collections of pages residing in a repository.

In its own words, *Jekyll is a simple, blog-aware, static site generator.*  This means one can run it to
creates a website.  To create page content, place files in a designated folder in *Jekyll's* directory structure.
These files can be conventional html  files, perhaps left over from a previous website, or, more
conveniently, files written with [markdown](https://help.github.com/articles/markdown-basics/) that it styles and converts to html, with templates for custom
formats such as headers and footers.

*Jekyll* is a command line application which includes a web server that is written in *Ruby*.  To run *Jekyll*,
*Ruby* must be installed on one's local machine, then the *Jekyll* package (a *Ruby gem*) installed for *Ruby*.
Then to expose the website publically, push the
*Jekyll* directory structure to a *Github* account created for that purpose and it's complete.

BTW, there is a *python* work-alike to *Jekyll* called *Hyde*. Be cautious about getting involved with this evil twin! As pythonic as one may be, the *Jekyll* installation is straightforward, and you'll end up learning about *Ruby* which is a really cool language.

Here's the [*GitHub Pages* documentation](https://help.github.com/categories/github-pages-basics/). In fact, one can create a
markdown-editable site entirely with *GitHub Pages*, but it will lack any *Jekyll*'s templating  nicenesses.  We won't go there. 

## The steps to get this in place

### Set up Jekyll in Ruby

- Install *Ruby* on your machine, if it's not already there. The current version is


> ~$ ruby --version  
> ruby 2.2.2p95 [...]


You'll also need *Ruby*'s package manager, *Bundler*.  *Ruby* comes with a built-in package manager called `gem` that manages *Ruby* packages that are called, naturally,  *gems*.  *Bundler*  is used to run *Ruby* in an environment that guarantees that the needed packages are loaded and up-to-date.

- Create the ```Gemsfile``` that *Bundler* uses to set the environment; [see the GitHub suggestion](http://jekyllrb.com/docs/github-pages/).

- Run

> $ bundle install

to implement that gems file in the directory where the Gemsfile resides, typically just below your repository directory. 
The trick is that this directory must be both a git repository and a *Jekyll* site.  I did this by first creating the *Jekyll* site, then creating the repository and copying the site's contents into the repository.  *Jekyll* will complain if you create a new site within an existing directory.

So, first the *Jekyll* setup:

- Create a Jekyll site, in a temporary dir.

> $ bundle exec jekyll new my_tmp_site

- You can try it out the site by building it, then running the local server to inspect it's pages

> $ bundle exec jekyll build my_tmp_site

Connect to the directory and start the server

> $ cd my_tmp_site; jekyll serve

It should respond with a message that you can browse the site, at ```http://localhost:4000```

- OK, cntl-C out of it (killing the server) and go to *GitHub* to  create the blog's repository.

### Create a user page repository

- Create an account on [github.com](https://pages.github.com) if you don't already have one. Otherwise create a new repository **whose name must be "your-github-account".github.io**

You'll create a *user page* repository assuming the repository you are creating is solely for hosting your blog, not as part of a documentation site for a code project. You can choose the README option, and optionally choose a license file.  (Or go to e.g. [creativecommons](http://creativecommons.org) and choose an appropriate license.)  *Don't go into settings and choose the auto-generated option!*  That's for a GitHub website that doesn't use *Jekyll*.  When *GitHub* sees the *Jekyll* directory structure in your master branch, *GitHub* knows to run your contents through the *Jekyll* templating engine and serve your site! 
To be exact, *GitHub* knows this because the repository name is the same as your account name, eg.   `jmagosta.github.io/jmagosta.github.io` to generate a  website from the Jekyll site at http://jmagosta.github.io.

Content from the master branch of your repository will be used to build and publish your *GitHub* site.

- To combine the repository and site directories, clone the repository

> $ git clone http://github.com/jmagosta/jmagosta.git

Then ```mv``` the entire contents of ```my_tmp_site``` to the root of the repository. (Note that the ```Gemfile``` stays at the level below, where you've been running *Bundle* commands. )

Then all that's needed is to commit and push the site contents to the new remote repository:

> $ git add .  
> $ git commit -m"new Jekyll build"  
> $ git push origin master  

## The edit, run, deploy cycle

Since *Jekyll* serves locally, and also identically on the *GItHub* server, you can see you changes locally simply by keeping the local server running as you edit markdown files in your repository. Start a local server in the root directory by running

> $ jekyll serve

The command responds with the location of `_config.yml` and the `_site` directory where results go.   It ends with instruction on how to view your work:

>    Server address: http://127.0.0.1:4000/  
>  Server running... press ctrl-c to stop.


Edits will appear as you refresh your browser pointing to ```localhost:4000```

Then when you want to deploy your changes, just push the repository commits to *GitHub*, so *GitHub* will see them.  That's all need be done to make the changes go ''live."

