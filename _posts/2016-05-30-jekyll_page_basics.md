---
title: Jekyll Page Basics
layout: post
---

Jekyll has two concepts for content, _pages_ and _posts_.  They start
with a few lines of `YAML` preface, followed by content written in one
of the markdown languages that Jekyll supports.  Both can include
template code, and both are interpreted by Jekyll and converted to
html.  These results are copied into the `_site` directory.  Content
placed in the `_posts` directory gets additional care and processing,
to be converted to pages that are listed chronologically on the home
page.  This is what it means by Jekyll being "blog aware" out of the
box.

Any markdown files in the root or its subdirectories with a `YAML`
preface will be processed as _pages_. Pages appear in the site as
static pages the the location they appear in the directory hierarchy.
Also, the theme that comes with Jekyll lists all pages it's processed
in the common header shown on each page. This is where the _about_
page link is shown.  (If you have a lot of static pages this is not
necessarily what you would want for the rest of your page contents.)





