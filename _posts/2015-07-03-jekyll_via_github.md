---
title: How this blog is built
layout: post
---

# Static websites hosted by *Github*, with *Jekyll*

Yes that's a mouth-full, but it describes the shortest path to setting up a blog for the modestly code-savvy blogger.
[Jekyll](http://http://jekyllrb.com/docs) is the simplest of all content management systems for building a website.
Github, if you are familiar with it as a code-sharing repository, incidentally also serves webpages. Think of
the `readme` file shown for each respository. So as a sideline, it's created a way for one to serve a collection of
pages residing in a repository.

In its own words, *Jekyll is a simple, blog-aware, static site generator.*  This means one can run it to
creates a website.  To create page content, place files in a designated folder in *Jekyll's* directory structure.
These files can be conventional html (&css?) files, perhaps left over from a previous website, or, more
conveniently, files written with [markdown]() that it styles and converts to html, with templates for custom
formats such as headers and footers.


*Jekyll* is a command line application which includes a web server that is written in *Ruby*.  To run *Jekyll*
*Ruby* must be installed on one's local machine, then the *Jekyll* package (aka Ruby gem) installed for *Ruby*.
Then to expose the website publically, push the
*Jekyll* directory structure to a *github* account created for that purpose and it's complete.

BTW, there is a *python* work-alike to *Jekyll* called *Hyde*. Be cautious about getting involved with this evil twin! As pythonic as one may be the *Jekyll* installation is straightforward, and you'll end up learning about *Ruby* which is a really cool language.

Here's the ]*GitHub* documentation](https://help.github.com/categories/github-pages-basics/). In fact, one can create a
markdown-editable site entirely as with *GitHub Pages*, but it will lack any *Jekyll*  nicenesses.  We won't go there. 

## The steps to get this in place are

### Set up Jekyll in Ruby

- Install *Ruby* on your machine, if it's not already there. The current version is

	~$ ruby --version
	ruby 2.2.2p95 [...]

You'll also need *Ruby*'s package manager, *Bundler*.  *Ruby* comes with a built-in package manager called `gem` that manages *Ruby* packages that are called *gems*.  *Bundler*  is used to run *Ruby* in an environment that guarantees that the needed packages will be there and up-to-date. (right?)

- Create the Gemsfile that *Bundler* uses to set the environment (See the GitHub suggestion).

- Run $ bundle install to implement that gems file (in the directory where the Gemsfile resides). (That should install  *Jekyll* also?)

The trick is that you'll need a directory that is both a git repository and a Jekyll site.  I did this by first creating the Jekyll site, then creating the repository and copying its contents into the repository.  Jekyll will complain if you create a new site in an existing directory.

- Now you can create a Jekyll site, in a temporary dir.

$ bundle exec jekyll new my_tmp_site

- You can try it out the site by building it, then running the local server to inspect it's pages

$ bundle exec jekyll build my_tmp_site

Connect to the directory and start the server

$ cd my_tmp_site; jekyll serve

It should respond with a message that you can browse the site, at http://localhost:4000

- OK, cntl-C out of it (killing the server) and go to *GitHub* to  create the blog's repository.

### Create a user page repository

- Create an account on [github.com](https://pages.github.com) if you don't already have one. Otherwise create a new repository **whose name must be <your-github-account>.github.io**  You'll create a *user page* repository assuming since you are creating is solely for hosting your blog, not as part of a code project. You can choose the README option, and optionally choose a license file.  (Or go to e.g. [http://creativecommons.org] and choose an appropriate license.)  *Don't go into settings and choose the auto-generated option!*  That's for a GitHub website that doesn't use *Jekyll*.  When GitHub sees the *Jekyll* directory structure in your master branch, GitHub knows to run your contents through the *Jekyll* templating engine and serve your site. 

To be exact, the repository name must be the same as your account name, eg.   `jmagosta.github.io/jmagosta.github.io` to generate a  website from the Jekyll site at http://jmagosta.github.io.

Content from the master branch of your repository will be used to build and publish the GitHub Pages site.

- To combine the repository and site directories, clone the repository

$ git clone http://github.com/jmagosta/jmagosta.git

Then mv the entire contents of my_tmp_site to the root of the repository. (Note that the Gemfile stays at the level below, where you've been running bundle commands. )

Then all that's needed is to commit and push the site contents to the new remote repository:

$ git add .
$ git commit -m"new Jekyll build"
$ git push origin master

## The edit, run, deploy cycle


