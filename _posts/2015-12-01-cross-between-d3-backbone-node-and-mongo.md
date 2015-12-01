---
title: "What do you get if you cross D3, Backbone, Node and Mongo?"
layout: default
metaSubTitle: "Library fusion"
pid: "cross-d3-backbone"
---

{: .header-image}
[![Blog Bg](/images/exit-header-2.png)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> There are so many JavaScript libraries and services out there now, of varying different flavours, that you can combine a mixture to get almost any idea quickly up off the ground. As long as that idea plays to the strengths of the code and the systems you choose.

<!--more-->

## The right tools

<div style="float: right; border: 10px solid white; border-radius: 20px; box-shadow: 0 0 10px 10px rgba(0,0,0,0.1); margin-left: 30px;">
  <img alt="Blog Bg" src="/images/exit-guy.png" width="160" />
</div>

I have been thinking about the kinds of things my E.X.I.T. project would need now for a number of years. I have stopped and started with bespoke code, started and stopped with open source solutions; even attempted to solve problems with existing, offline software. Each time, either the tools have not been quite right for the job, or there has not been enough available (and consecutive) free time to keep that particular iteration alive.

Now, after much more experience in using particular libraries and services for other clients and projects, I have actually been able to make some consistent headway. Mainly because &mdash; on top of knowing the individual tools themselves quite well &mdash; I also now know what their strengths are, and how they can work well with others.

Put simply, I now have the right tools to build my ExitGuy Animator:

* **Data Visualisation and Manipulation**
  1. D3
     <br /><br />
  
* **Storage and Server communication**
  1. Backbone, Underscore, Backbone Associations &amp; jQuery
  2. Express, Mongoose and MongoLab.
     <br /><br />
  
* **Front-end UI**
  1. jQuery
  2. jQuery UI
  3. jQuery Chosen
  4. jQuery Toolbar
  5. Font Awsome
     <br /><br />

## Through the Force, things you will see.

First up I want to sing the praises of D3.

I always enjoy working with well designed systems, but give me a well designed system that I would not have been able to create myself &mdash; that's even better.

### Why D3?

For me D3 has been another shift in perspective. Just the same as jQuery was, back when I was still using my own &mdash; `traverseTheDOM()` in the `.getMostPedestrianMannerPossible()`, whilst `ignoring > the .simplicity of #CSS selectors` &mdash; code&trade;. Sure my bespoke libraries were good, well written, but they were lacking the change in perspective that made everything so much easier to work with and read.

D3 brings this perspective shift to that of data visualisation (and more). Not only does it make working with SVG easy, it allows you to take any type of data you like and make it instantly more accessible to everyone. That can only be a good thing.

Usually when I encounter code I really like, my first thought is to see how many of my current ideas I can thread it in to. Which can sometimes work, and other times lead me off generating enigmas wrapped in rabbit holes. It wasn't until I came across D3's force layout however, that I started macgyver-ing things that made sense. At least for my own projects.

### Force = Mass * Acceleration / Who needs Inverse Kinematics?

That is probably the weirdest title I've ever written, but what it describes has saved me a lot of headache.

Early implementations of the ExitGuy animator have toyed with the idea of using Inverse Kinematics to rig the ExitGuy Skeleton. This is not an idea to toy lightly with. It took a lot of reading, experimenting and writing of code mixed with help from all sorts of locations. Actually, quite a bit of time was taken porting complicated equations (that my mind has no clue about) across from other languages (or darwin-forbid actual Mathematical formulae) into either JavaScript or ActionScript (yes I've been working on this for a while).

Back then time was free, spirits were brave, people were real people, and small furry creatures from Alpha Centauri were real small furry creatures from Alpha Centauri. Which meant I could spend a lot of time messing around without getting any actual results.

It is true that youth is wasted on the young, because if I had that kind of time now and this kind of impatience then, I would have quickly seen that I wasn't going anywhere fast &mdash; and I would have looked for another solution. I did eventually do that, but next choice was Box2D. Using a physics engine definitely improved my position, and made certain things easier; but it made a whole lot of other things much, much more difficult.

So, much time (and discovering D3) later... I realised that by simply changing the configuration of a D3 Force Layout, I could mimicking that of what I had been trying to build all along:

A posable skeleton.

Compared to Inverse Kinematics it was much much simpler, and compared to Box2D there was no gravity or settling issues. Plus, everything was working directly with JSON, so I got easy import and export for free.

Perfect.

## What good is a skeleton with no Backbone?

Next up is the nice implementation that is Backbone.js.

I had not had a huge experience with Backbone before this project, but I had read a lot about it in many places. So I knew what it could and couldn't do off the bat. I knew I was looking for a way to represent my server-side data as malleable objects on the client-side, and that's exactly what Backbone was for.

The beauty of coming in to a well established library, that's been improved over years and years, is that there are so many examples out there you can answer nearly every question you have about the system in a very short space of time. I managed to couple my front-end UI to my Backbone layer, which in turn coupled back to my Node powered rest API, in no time at all.

So I went from a pretty, but rather useless UI, to something that persistently remembered what I did with it over a weekend.

## Five minute REST

Up till this point, if I thought I had been working quickly, I was most definitely wrong.

> Well actually, it is thanks to all the other nice open source coders out there &mdash; especially those working in the Node world &mdash; that should take the credit.

Put simply, I managed to build my RESTful API layer in 5 minutes &mdash; thanks to Express and Mongoose. True it was the basic shell of a system, but it worked enough to give Backbone everything it needed; and was functional enough to handover whatever Backbone asked directly back to MongoLabs.

So now I create a new Animation in my ExitGuy Animator UI, and instantly the data is stored, ready and waiting in MongoLabs back-end UI. I reload the page and my changes persist.

Building this before Node, I would have opted for either Python or PHP. Both of which would have definitely taken significantly longer.


## The next steps?

For now the system is still basic but it is demo-able. Here is part of the UI ripped out, just to give a feel for what I'm talking about. The real system will go live once it is fully ready.

<center>
<iframe width="600" height="400" src="http://pebbl.co.uk/exit/animator/" frameborder="0" allowfullscreen></iframe>
</center>

In the coming months I hope to improve the usability of the interface to allow for quick construction of stick figure animations based around key frames and tweening.

I wanted a controllable (and programmable) animation environment precisely because the animations that are created are not going to be rigid. They will be heavily computationally processed, and in places affected by a simplistic AI. The data will be used to do the following:

1. Automate the creation of skins &mdash; layers that will sit atop the skeleton.
2. Calculate the direction of limbs and force of movement &mdash; which will help when the rigid Force skeleton switches to a Box2D rag doll.
3. Specify hit-receiving and hit-making areas &mdash; to aid in regard to character collisions.
4. Creating a look-up matrix of which animations can seamlessly blend to others.
5. Creating a look-up matrix of which animations should be used when encountering an enemy figure's animation.

Out of all my research I couldn't find an existing animation system that had these abilities, so I created my own. It may seem like a lot of work, but when you've been contemplating making a game that attempts to reproduce at least some of the following, you need all the power you can get:

<br /><br />
<center>
<iframe width="600" height="400" src="https://www.youtube.com/embed/MdzHpr-QZhw" frameborder="0" allowfullscreen></iframe>
</center>