---
title: "Why Jekyll?"
layout: default
metaSubTitle: "Why Jekyll"
pid: "why-jekyll"
---

{: .header-image}
[![Blog Bg](/images/jekyll.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I'd been looking for the best way to approach the redoing my blog for a while. There had been a number of attempts, mainly bespoke code utilising a flavour of Markdown. I had also been looking for an excuse to work more with Ruby, something I had dabbled with in the past, but not really got to grips with.

Then I came across Github Pages, which in turn led me to Jekyll...

<!--more-->

## Ruby, Git and Mr Hyde

...and in a very short space of time I had already overtaken the abilities of my bespoke systems without sacrificing too much control. I also found I could tinker with the underlying Ruby, or extend it with Plugins, allowing me to learn more whilst simultaneously improving the abilities of the blog.

## No need for caching

One of my key gripes with a lot of the large scale projects I've worked on over the last few years, is the automatic reliance on caching. Many developers, it seems, have got into the habit of using systems that are extremely wasteful — in terms of processing. All because they can easily fall back to the likes of Varnish — or even more invasive forms of code caching — to save the day.

Drupal is a great example of this, and has always been my main reason for disliking CMSs to that of bespoke coded systems. The last three Drupal sites I have worked on, have been so heavily cached, that there was almost no point in having a dynamic site in the first place.

The problem with caching is that in my experience it causes almost the same number of issues as it solves, just in different areas. Not to mention that the issues it does cause, tend to be a lot more cryptic. Basically, rather than having a site that may crash if there are too many requests, you instead have a site that becomes a pain to develop for.

This is why my preference for any type of content managing system has always been towards that of a "publishing" process. Meaning that you manage your content using whatever clever tools you can put together, but the site that your users view is always a static generated version — or at least as static as possible. This way your site is as simple and optimal as possible in terms of being served to your users. At most you may wish to opt for some edge-caching for your assets, but that is about it.

... and that is exactly the way Jekyll seems to work, so that makes me happy.