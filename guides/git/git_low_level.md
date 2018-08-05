---
title: Low Level Commands 
layout: page
---
# Git[^fn]

##  Low Level Commands

[^fn]: J. Loeliger & m. McCullough, "Git" O'Reilly 2012.

`Git` has a set of commands that translate between the git hash-based organization of content and the repository file system. This is possible because of the magical one-to-one correspondence between a file's contents and its SHA1 key.

1. To view the contents of a _blob_ in the repository from its SHA1 key:

		$ git cat-file -p <SHA1-key>
	
2. The inverse lookup, to find a SHA1 key from a tag, file-name?  etc.

		$ git rev-parse <name>
    
3. To run the SHA1 hash on content

		$ git hash-object <file-name>
	
4. To see the correspondence in the index between files and their keys.

		$ git ls-files --stage

Day-to-day commands are composed of lower-level commands such as these that are exposed to create `git` objects.  

1. To create a tree node from the current index:

		$ git write-tree 
	
2. The SHA1 key returned for the tree is used to write a commit node to stdout:

		$ git commit-tree git write-tree -m"Here is a commit node"
	
3. Human readable git objects:

		$ git show <some-object>
    
*****

## Useful obscurities

1. The inverse of `git add`, to unstage a file (remove it from the index) without reverting to the previous committed version:

		$ git rm --cached <file-name>
    
In general the `--cached` switch applies the command to the index. Along these lines, 
[this](http://blog.jonathanchannon.com/2012/11/18/gitignore-not-working-fixed/) shows how to restore `.gitignore` to its proper function

		$ git rm -r --cached .
		$ git add .
		$ git commit -m"fixed gitignore"


2. To see the sequence in the log on a file that has been moved or renamed:

		$ git log --follow <file-name>
    
    
    
    
	
	
