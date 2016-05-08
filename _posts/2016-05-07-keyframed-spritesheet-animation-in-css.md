---
title: "Generating keyframed animations using CSS spritesheets"
layout: default
metaSubTitle: "Generating keyframed animations using CSS spritesheets"
pid: "keyframes-animations-css"
---

{: .header-image}
[![Blog Bg](/images/css-spritesheet.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> Above you should see some of the pixel keyframes for Annabelle. She is a character in my ALWTM game... and as such, she has been animated using at least five different systems over the years. I have versions of her character in SWF format, SVG animations, Canvas & JS, Spine both JS and Unity runtimes, not to mention other asset managers for Unity. Each time I've tried a new implementation I have discovered benefits and drawbacks.

<!--more-->

Now that I'm working on a ALWTM HTML5 Demo — that integrates with v4 of my company website — and after discovering that the Spine JS runtime is not best suited for what I wanted to do... I needed to find a more optimal approach.

I started investigating CSS keyframed animation purely as an experiment — based on the idea that browser-native will be faster and less intensive — but now I am quite certain this is the route I'll take.


## What do I mean by CSS sprite sheet animations?

If you haven't come across Sprite sheets, then I'm not sure where you have been... or perhaps you've jumped back from a http-2-infused future that has no need for such connection-overhead-saving devices?

However, I can fully understand if you haven't heard of Sprite sheet <em>animations</em> in CSS. This is all thanks to a special timing function called `steps()` which allows for a broken/jumping/disjointed transition motion — rather than the smooth transitions of linear, ease and the rest.

A good example of this timing function being used to power CSS animations can be found here:

[simurai.com/blog/2012/12/03/step-animation](simurai.com/blog/2012/12/03/step-animation){:.external}

## CSS vs JS

There are a number of reasons why I have decided to stick with CSS keyframed animation for this project in particular:

1. The browser handles all of the optimisation and redraw handling.
2. Support for `animation-timing-function: steps()` is much better now.
3. Out of my tests, performance across multiple devices has been impressive, much more so than the Spine JS runtime or my own simple canvas implementations.
4. ALWTM is a special/mad case in terms of game design. Unlike my other games, whereby I might use Phaser/Pixi to build everything inside a Canvas viewport. ALWTM is designed to be a website, and so everything is built using HTML elements (at least currently). I may come to my senses later on...

For my purposes I have only come across two downsides to CSS Keyframes.

1. In order to get an animation to replay, some reflow tricks are required.
2. If the browser does not support `steps()` then the result is almost comical<br />(see the "Without steps()" tab below).

## Generating Sprite-sheet and Styles

The following example isn't just an example of using CSS keyframed animation, it is also an example of programmatically generating the sprite-sheets required for the animation — and at the same time building the animation styles. Because I had put the work into creating the Spine format for Annabelle, I thought I might as well take advantage of the JSON that Spine can export.

So I built the example below to scan the Spine data, finding each "attached" frame, load it, and then paint it to a Canvas element. From there we can export the image information in the form of a Data URI. This creates our sprite-sheet. For now the sprite-sheet is generated on each request of the demo, but there won't be anything to stop me setting up a build process that does this when I publish, rather than at runtime.

If you are interested, just fire up your net inspector. You will see each of Annabelle's separate frames, and the Spine JSON data being loaded. If you want to see the finished sprite-sheet, just inspect Annabelle, and view the background image in use on the `.anim-buffer` element.

This preprocessing allows for additional abilities that were not available in my previous attempts. You can already see directly one of these abilities, in the fact that the reflection in the example below is another generated sprite-sheet. Created at the same time as the original animation sprite-sheet, but with effects and translation applied. Pretty cool I think.

<div class="use-easytabs">
  <ul class="nav nav-tabs">
    <li class=""><a href="#iframe-steps">With steps()</a></li>
    <li class=""><a href="#iframe-nosteps" class="">Without steps()</a></li>
  </ul>
  <div class="panels" style="">
    <div id="iframe-steps" style="display: block;" class="active">
      <iframe src="http://codelamp.co.uk/blog/generation/index.html" style="width: 100%; height: 150px;" scrolling="no"></iframe>
    </div>
    <div id="iframe-nosteps" style="display: none; position: static; visibility: visible;" class="">
      <iframe src="http://codelamp.co.uk/blog/generation/index.html?nosteps=1" style="width: 100%; height: 150px;" scrolling="no"></iframe>
    </div>
  </div>
</div>