---
title: "Remaking Codelamp's core website"
layout: default
metaSubTitle: "Remaking Codelamp's core website"
pid: "codelamp-v4"
---

{: .header-image}
[![Blog Bg](/images/codelamp-v4-blog.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I actually started v4 at the beginning of last year, but have only had the time free recently to finish it. I think I can now safely say I know a great deal about horizontal parallax in websites (considering I've been working with one for over two years)! V4 was designed with an extra caveat this time however. It will need to migrate easily to v5 — which is already underway.

<!--more-->

This is the reason why the site is divided into the presentation framework (the parallax navigation), and the content — which is presented in minisites.

This is so that for v5 I can switch in a new presentation framework, which you can already see hints of in the headers of the minisites. You can be sure this time, it won't be Parallax.

It also explains why half the site is written using web components, and the other half with a bespoke JavaScript build.

Visit the site here: [Codelamp Version 4](http://v4.codelamp.co.uk){:.external}

## Refactoring

### v3 vs v4
V4 is a complete refactor of v3 in terms of the parallax handling. I was never quite happy with some of the implementation of v3, and whilst there are still elements of v4 I'd like to rework on — I'm much happier about the new implementation.

Nearly all of v3 was handcrafted, which meant I wasn't benefiting from the power of computation at all. This time round, v4 uses a lot of the process I've settled on after working on my JS library ([Theory](http://github.com/codelamp/theory){:.external}) for so long. That being the "Describe it, build it, release it" process.

Describing your system in something higher level, and then using a build process to generate the detail and complexity, is a very powerful concept. It can avoid much of the [Coding Sensibility]({% post_url 2015-10-10-coding-sensibility %}){:.internal} problem that I've written about before... but in order to do that, it has to be done well.

### v5+

Unfortunately, due to time constraints, v4 is a little hurried in its "building"... but I've learned a lot from its implementation. And I think next time round I might look to something like metalsmith in future, either that, or refine my own bespoke system.

## Web Components

Back when I started v4, web components were still "very draft", and the kind of thing I'd look at and then feel my brain start to day dream about the bright future of the web. My major lament in being the age that I am, is that in order to achieve anything on the web — say, back in 2000 till 2008 — there was an awful lot of boilerplate work.

### This isn't a complaint, but ...

It is always frustrating when you can see what can be achieved, but in order to realise your ideas, you have to build a lot of framework first. Much of my initial time coding for the web really only turned out to be prototyping. For example, I spent much of 2007 building my own component/data-binding system, very much like that of Angular or React today. But, I also had to build the useful web components themselves, like file uploaders, or WYSIWYG widgets. Not to mention, finding my way round huge numbers of issues that have now be helpfully solved by determined teams, amazing browser developers and the passing of time.

I then spent much of 2008 building a game engine called Twerp.

### It really isn't a complaint

Now I can't really complain, because those projects have meant I have a much wider knowledge-base than I ever would have had without it. There aren't many that can list the following as attempted projects:

- WYSIWYG Editor (both in JS and Flash)
- Multiple File Uploader (again, both in JS and Flash)
- 2D Animation Editor
- Skeletal Inverse Kinematic Rigger
- 3D Render Engine
- 2D Game Engine
- Peer to Peer Communicator
- HTML Renderer (inside Flash??)

The problem is that none of those were my actual end destination — they were the base elements. The above can be grouped together into what I was actually trying to achieve.

- Online Collaboration Tool
- Data Visualisation and Component System
- Several 2D Games

### Alright, yes I know I'm sounding old

These days there are so many great building blocks to get your "over-ambitious" idea actually finished, you don't need to worry about much of the ground work. From the game perspective there are great tools like Phaser and Pixi, from the data visualisation point of view you have D3, and other great UI libraries. For communication you have WebSockets. And now that we are starting to see Web Components, this is where people can start to build very useful elements that you can just plug in and get going with.


### ... this did have a point

This is why v4 is a mixture of my older approach, and now my newer, component led approach. Not because I didn't want to use components before, it has always made sense to use components to me (since way back in 2007) — it was just that in order to achieve that approach, there would have been a lot of preventative ground work.

So my old approach could probably be summed up as "separate code by file and object namespace", but "rely on either generated / existing markup elsewhere". However, now, thanks to Web Components — you can tie your code, css and markup together in one bundle... meaning you are much less likely to get lost, or confuse other future coders.

Anyway, waffling aside, here are a few of my component-powered pages. They are all still WIP, as I only had a week-or-so to put them together, but they've helped me learn a good deal about what is possible right now.

- [RiotJS](http://v4.codelamp.co.uk/subsites/riotjs){:.external}
- [Pebbl](http://v4.codelamp.co.uk/subsites/pebbl){:.external}
- [Gadgets](http://v4.codelamp.co.uk/subsites/gadgets){:.external}
- [Exit](http://v4.codelamp.co.uk/subsites/exit){:.external}

## That good ol' CSS

Yes, a new site, so that means new attempts at achieving things with only CSS in-mind.

I know these days everyone expects JavaScript to be running, there are even Dining room Tables out there running a version of ECMASCript, I'm sure. But I like the challenge and the puzzle of trying to implement something that the browser will automatically manage for you. One thing I've wanted to try, but not had the chance, is to tie my recent parallax stuff into visual pockets dotted about a page. And because I already had a number of JS-powered components climbing up the walls, I wanted to avoid any extra script.

Below you should see a codepen of my first attempt.

<p data-height="265" data-theme-id="0" data-slug-hash="Mmzvqr" data-default-tab="result" data-user="codelamp" data-embed-version="2" data-pen-title=".hover-grid" class="codepen">See the Pen <a href="https://codepen.io/codelamp/pen/Mmzvqr/">.hover-grid</a> by Phil Glanville (<a href="https://codepen.io/codelamp">@codelamp</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

The system shouldn't need much explanation, it essentially layers an interactive "hover grid" above the parallax screen, and uses the current hover target to work out the viewers desired perspective. I had hoped to get a better resolution from the hover grid, but it seems the number of css selectors or perhaps just the computation of so many interactive elements, causes it to be unworkable on many browsers. This is the reason for the larger grid, which gives a clunkier feel — but still seems to work ok.

Here is a slightly optimised version, with less CSS (and less less), but more js-computation.

<p data-height="265" data-theme-id="0" data-slug-hash="ybQodK" data-default-tab="result" data-user="codelamp" data-embed-version="2" data-pen-title=".hover-grid v2" class="codepen">See the Pen <a href="https://codepen.io/codelamp/pen/ybQodK/">.hover-grid v2</a> by Phil Glanville (<a href="https://codepen.io/codelamp">@codelamp</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

## Build process

v4 is the first of my personal websites to benefit from a build process (if you ignore this blog, which is run through Jekyll). I did test around with Gulp for a bit, but actually decided just to stick with npm and specifically built bash scripts, at least for v4. This has led to a hierarchy, where the main site's build process triggers off the microsites processes — which seems to work quite nicely, at least for this size of site.

Some of my microsites are using Browserify to bundle things up, which I quite like, and others are using Babel to transpile future JavaScript to current JavaScript (which I still find creepy).

One step I haven't yet finalised however is the no-js build for the main site. Previously v3 worked whether you had JavaScript or not, v4 however will only work with JS-enabled. The site itself however, has been designed to work without JS, I just need to finalise the build so that the final index.html is running the right includes and initial class names. Once that is complete, you'll be able to navigate the site (in full CSS parallax) without any fancy runtimes.

## Hosting

V4 is the first of my sites to be hosted with Google Cloud. I did so just to get up-to-speed with what they are offering, so that I can advise future clients. So far I have been impressed with the sheer amount of "extras" that are available. I'm really hoping I get some more free time this year so I can try a few of their special features out.

For now though at least, I'm happy in that just like with my previous Heroku builds, and GitHub/Jekyll builds, I can merge down to master and push — and within a minute, the latest changes are live with an impressive set of admin tools and stats.

Once thing that is still irking me however, and I guess this comes with running on the ambiguous "cloud" — and especially a cloud system with a complex interface — but I can't find what technology is currently powering my "static" v4 site. Before, I've always been fully aware. This is an Apache/PHP stack here, that one is a Heroke/Node buildpack, other there... the one on Google, in that container... erm, well I think it runs on a mixture of Go, Lisp and luck.


... to be continued ...