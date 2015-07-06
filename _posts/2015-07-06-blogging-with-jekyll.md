---
title: "Blogging with jekyll"
layout: default
metaSubTitle: "Blogging with jekyll"
pid: "blogging-with-jekyll"
---

{: .header-image}
[![Blog Bg](/images/jekyll.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I thought I'd outline the steps it took for me to get my Jekyll-powered blog up and running. Once I had Github Pages installed locally everything has been a breeze. However, that first step of actually getting "Github Pages installed locally" was more like sailing into the wind.

<!--more-->

## "Psst. Where's libxml2?" -- Nokogiri

    libxml2 version 2.6.21 or later is required!

or

    libxml2 is missing.

This was the first and only stumbling point, and it seems I'm not the only one to fall into this problem. Although it seems to be one of those problems — like the infamous `Class name must be valid object or string` with Drupal, or the `JS Error on line 0, char 0` with ye olde internet explorer versions — where there are many causes, and far too many solutions.

I'll start by describing where I went wrong, and then work backwards... which is exactly the opposite of how my morning disappeared into something that should have been very easy to install.

## rbenv

First off, I haven't worked much with Ruby, beyond having a perpetual interest in different computer languages — meaning that if I hear of one that interests me I tend to install it just for kicks. So, due to my lack of experience it meant I was at the mercy of whatever tutorial or "quick start" steps I was following. They recommended that I install `rbenv` so who was I to question it.

The problem was however, that the installation steps for `rbenv` didn't mention two major points:

1. That I needed to modify my `PATH` var.
2. I needed to execute an `init` method.

Nearly all other "environment managers" that I've installed have been ready to roll from installation. This was not the case with `rbenv`. So, just in case you haven't done this, you will most likely need these two lines at the end of your `~/.profile`:

    export PATH="$HOME/.rbenv/shims:$PATH"
    eval "$(rbenv init -)"

The above in itself wasn't enough to cause all the problems, but if this hadn't happened, it would have been solved a lot earlier. All the above did was mean that no matter how I used `rbenv` — to change the version of Ruby I had installed from 2 to 2.2.2 — it wouldn't actually change what I needed to change.

## Bundler

The tutorial then went on to describe that I should use `Bundler` to download the "github-pages" gem (or gemset, or bundle, or... I don't know what the correct Ruby terminology is). So I installed it. It was this that kept complaining about `libxml2` being missing. And no matter what I tried to change, nothing made any difference. Here are some of the steps I tried:

1. First port of call: Upgrade Ruby from 2 to 2.2.2 (as per the tutorial).
2. Make sure `libxml2` was installed using Homebrew. Yep.
3. Make sure `libxml2` was the right version. Yep.
4. Make sure I had x-code... *Yes, I have x-code.*
5. Run Bundler with `--use-system-libraries`. Yep.
6. Run Bundler with even more specific locations of `libxml2` using `--with-xml2-lib` and friends. Yep.
7. Continue to get the message from Nokogiri that `libxml2` couldn't be found or was the wrong version. Yep.
8. Make sure I had x-code... *Yes, I have x-code!*
9. Attempt to install Nokogiri using gem, with the extra arguments... aha! Success!
10. Run `bundle install` again to attempt to complete the `github-pages` install. Still fails with the same message, What?
11. Realise that `bundle` was somehow still accessing ruby version 2, even if `terminal` wasn't.
12. Discover, after much searching, that rbenv wasn't initialised.
13. Initialise rbenv.
14. `bundle install` again — note how all the gem-bundle-sets reinstall, obviously for the new version of Ruby.
15. Despite many tutorials stating that having `libxml2` installed with Homebrew would be fine, finding that it wasn't.
16. Definitely having to specify the `libxml2` location with the following code:
    `NOKOGIRI_USE_SYSTEM_LIBRARIES=1 gem install nokogiri – –use-system-libraries –with-iconv-dir=“$(brew –prefix libiconv)” –with-xml2-config=“$(brew –prefix libxml2)/bin/xml2-config” –with-xslt-config=“$(brew –prefix libxslt)/bin/xslt-config”`
17. Finally everything installs and just works!
18. I don't even like XML anyway...

## Conclusion

So far, blogging with Jekyll has been great — despite the initial bump in the road. Mainly because I love Markdown, I feel like I have a lot of control over how the site is created, and I don't have to worry about database storage or boilerplate. I also love the fact that it generates a static site at the end of it. I'm getting used to Liquid, but it is so nearly identical to Twig or Handlebars, that the curve of learning seems minimal.

If only I could get more clients to agree to this model of site building...