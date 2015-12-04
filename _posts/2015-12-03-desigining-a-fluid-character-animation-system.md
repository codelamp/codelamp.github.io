---
title: "Designing a fluid character animation system"
layout: default
metaSubTitle: "Fluid animation"
pid: "desing-fluid-animation"
---

{: .header-image}
[![Blog Bg](/images/exit-animations.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I've been virtually designing a good way to achieve an animation system for a number of years, virtually, as-in thinking about it. a lot. So as I have a moment whilst out job hunting, managing to grab a burrito, I thought I should note these ideas down &mdash; in the off-chance that I ever actually get enough time to implement them.

<!--more-->

## The issues to solve

Ok, so first up, as with any system I need to be clear on what the issues are. I'm sure anyone who has attempted to construct an animation system has come across many of these problems &mdash; as they are fundamental to any character-based game.

<br />

### Animation flow disruption

This is a made up technical sounding name for "What to do when the animation suddenly needs to change". This obviously occurs a lot, especially with a high-collision game like that I am hoping to build. There are four common solutions to this issue:

1. **Create enough animations that you have almost every conceivable break in the animation accounted for** &mdash; For example, you have a running animation, and you would like to add an animation whereby the character running can hit their head. Here, because you have holistic frames, you would have to animate the head collision animation at multiple points through the running animation. This is because the character can hit their head at any frame whilst running. This obviously works as a solution, but the amount of animations that need to be constructed can end up being unsurmountable.

2. **Don't worry about it** &mdash; many games employ this. Whether it works due to their chosen style, or just doesn't work and the animation is choppy. It is a solution. For many games it doesn't really matter if the animation is disrupted. It is far more important that the animation doesn't overrule the user's control system.

3. **Allow the animation to continue until the next animation break point** &mdash; this is similar to point 1, but allows you to cut down the number of animations required. This solution is visually great, but from a control system point of view it is only as good as the number of animations you have. I have played very frustrating games that did not have enough animations created, and rather than just allow the character to jump from one state to another, the system forced the user to wait until the current animation had finished.

4. **Programatically control your character** &mdash; this usually can only work if you can procedurally generate your animation frames (i.e. you aren't using frames, e.g. you are animating 3D/2D models or skeletons).

For my other project (ALWTM) I implemented something similar to point 3. It was written in ActionScript 3 and implemented an animation bridging facility. The code scanned what was essentially rasterised image-based keyframes, and automatically guessed at what were similar frames. It then created a matrix look-up based upon these similar frames. Then as the animations were being used, if a new animation was enqueued, it would identify the nearest bridge and que that as a jump point. This system worked well, but only where I had allowed for enough bridge frames. In areas where the weren't enough bridges, the character appeared slow to react.

With my E.X.I.T. project I hope to implement something more akin to point 4, using a vector skeleton, with wrapped vector skins.

I want Exit's animation to be smooth and fluidic, whilst simultaneously not hampering the control system. This is going to require quite a bit of manual animation &mdash; because fully coded animations tend to lose natural mannerisms &mdash; but also a programatic layer on top.

This programatic layer will be responsible for:

1. **Tweening the motions between keyframes** &mdash; this should mean I will only need to animate key frames, the code can do the rest. It will also make it easier to blend between animations &mdash; without the need for bridging animations.

2. **Rasterising the animations to something quicker to display in a Browser/JS environment** &mdash; Because E.X.I.T. will be a browser-based game, the animations themselves need to play quickly. Whilst I may have this complicated skeletal system in play, it will not be present during the game's runtime. That would be too much processing, especially for smaller devices. The benefit of being able to process the character's data like this will also mean I can generate different "frames" for different devices. This will allow me to use whatever is most optimal for a particular system. For desktops I am hoping to use SVG for each frame, however this may prove too much for other devices, and perhaps I will need a canvas (or even PNG) renderer in those cases.

<br />

### The issue of scale

One problem I quickly ran in to with ALWTM was that I couldn't easily scale my main character. She had been carefully pixel animated, very small, specifically to give a sense of scale to the world. The problem is that I started realising that in some circumstances I wanted to zoom-in, so as to be closer to the game action. With a pixel-based character, this just didn't work.

I did contemplate animating Annabell (ALWTM's main character) using vector information. I even tried a couple of times, but I wasn't able to get the nice pixel feel to the end result. E.X.I.T. has never needed this pixel feel, in fact the game design has been specifically chosen because it should be vector friendly, so this makes for approaching the animation system easier &mdash; where at least zooming is concerned.

With the current animator it is all based in SVG. Meaning I can size the character to whatever dimensions I need. Also, because I am implementing a tweening system, it means I can do something else that is difficult with pixel-based animations. I can do slow-motion, something which I hope to exploit.

Vector is not without its downsides however. When using rastered art, it is easy to add small details and other colourful effects. Vector-based systems can implement effects like blurs, glows or shadows... but their support tends to be unpredictable, and not to mention slow from a performance perspective.

<br />

### Collisions and hit-areas

When dealing with raster animations, it can be quite easy to specify hit-areas. These are usually implemented as square or polygon regions that can be animated along with the character. The problem is that it takes time to add them in.

With E.X.I.T. I hope to generate the hit-areas by specifying what which nodes of the character can cause a collision, and what nodes of a character can be involved in a collision. From there I will compute where collisions can occur without too many problems. In terms of animating, I just have to turn on or off this ability for certain nodes at certain points... no further effort required.

This also will help with the next point.

<br />

### Realistic reactions to collision

In most games with hand animated characters you will see a set few collision or death sequences. These will either be chosen randomly, or depending on what has caused the collision and/or death. For E.X.I.T. &mdash; because it hopes to be based on realistic martial-art-esque fighting &mdash; this would involve a lot of animations. There are alsorts of ways a character can be kicked, leaving them to fly off in a manner of different ways.

So, on top of specifying which nodes can be involved in collisions, the programatic process will be responsible for calculating the direction of movement of each of these nodes in 3D space. My current animator has the ability to describe where in 3D space a node is, so this should be quite possible. I will also be able to add meta information to each node to describe the "power" of the motion. This value could also be calculated from the speed the node appears to be moving, but in some circumstances the visual movement may be weaker than the expected force of the maneuver.

> It should be noted that even though the nodes are calculated in 3D space, the collisions will be calculated only in 2D &mdash; purely for simplicity.

Now that each node knows where it is going, and how "powerfully", we can do something quite clever. We can switch internally from a rigid SVG (Powered by D3's Force Layout system) to that of a skeleton powered by Box2D. We can then apply the correct force and direction to the Box2D rag-doll.

> With my tests Box2D was too intensive to work with anything complicated at a game level, especially on smaller devices... however, using it to pre-calculate animation frames is very do-able.
> <br /><br />
> The only tricky element to this approach will be getting the Box2D skeleton to mimic the D3 skeleton as close as possible for the initial handover frames. This will probably involve giving the legs of the figure some momentary force, just so it doesn't look like the character just collapsed under the weight of all the gravity floating around the room ;)

<br />

### Falling down

So once we have decided that a collision is powerful enough to switch a character from being ok, to being knocked over, we can switch to the Box2D representation. This will give a realistic idea of how the character would fall or be thrown. This is quite similar to what 3D games do &mdash; like HalfLife 2+ &mdash; when an NPC is killed.

> Using a physics simulator for an entire character's lifespan is tricky. Mainly because physics systems are notoriously difficult to tame so as to avoid glitching, or to keep at a stable equilibrium. This is especially true when doing complicated things like getting a biped to stand still. A simulator is very good however to use as a temporary system, to help work out how something might fall through space.

Basically the plan would be to create a "Construct" of `The Matrix`&trade; fame. A place where two characters could be loaded and have a stand off. The reactions of the characters would be calculated in runtime &mdash; rather than pre-calculated. Each collision or reaction would be recorded and logged as a specific animation under a look-up matrix. The most common reactions &mdash; based upon statistics &mdash; would be bundled up and used, pre-calculated, for the game's runtime.

So, the more frequently this Construct would be used. The more comprehensive the in-game animations would get &mdash; up to a point. That point would be the size of the look-up matrix. I would have to find some way of boiling very similar animations down to the same resource, otherwise the download would get too sizable &mdash; even for Desktop machines.