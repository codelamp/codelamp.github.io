---
title: "Developing fullscreen responsive horizontal parallax, with navigable depth."
layout: default
metaSubTitle: "Developing fullscreen responsive horizontal parallax, with navigable depth."
---

{: .header-image}
[![Blog Bg](/images/blog-bg.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I first started the ground work for this my new website back in 2013. I had built some other parallax systems in the past, but nothing as complex (or as my autocomplete would say, cupboard) as what I wanted for this site. The complexity increased still when I discovered that the first iteration suffered a number of glitches when testing across different operating systems and browsers.

<!--more-->

## Glitches

The most annoying of these glitches had no apparent cause, no way to detect, and almost no fix — and was definitely a browser (or underlying os) bug. I couldn't even predict when it was going to occur. Usually these glitches are small and can be covered up or ignored, but when the entire background of your painstakingly designed site decides to vanish in a haze of `#000000`, it's rather difficult to ignore.


I attempted numerous workarounds and fixes. Changing image formats, switching from backgrounds to images, switching from 3d transforms to 2d, slicing images into smaller parts, using pseudo elements, using multiple backgrounds, using multiple layers. Nothing changed. Switching from using transform to positioning did fix the issue, but performance ground to a halt. I even tried suggested fixes (thanks Stack Overflow) for flickering backgrounds with `backface-visibilty`, and other such cssisms, to no avail.


It seemed that the main trigger for the problem was when a layer with a background image achieved a size wider than 1500, or was scaled....


At that point I gave up, putting it down to the transform technology not being ready yet. Then I ungave up a week later, annoyed at the time I had put into the site, and attempted one last fix. Surprisingly that worked, although later I realised that I had already worked out a similar problem to what I was experiencing a few years before.. But it was under a rather different context. Basically the fix went like this. Don't use whacking great background images and hope the browser will render them correctly, instead use whacking great canvas layers and draw the images once, and only once, at page load/ready.


The flickering and disappearance vanished, and with the exception of Safari, performance was pretty much the same. Great, I thought, now it's safe to move on to the rest of the site.


I'm not kidding when I say a week later both Chrome and Firefox released browser updates, and the performance of the parallax dropped to smooth and clunky at best.


Damn it!

> It's not that I'm so smart, it's just that I stay with problems longer. *Albert Einstein*

## Try, try, again.

It was at this point that I refactored both the markup and the CSS involved. Changing from a simpler CSS and layer design, to one I had been hoping to avoid, mainly because it was going to be a CSS headache.


Before I had kept transformations separate for each 3D axis. One layer for x movement, one layer for y, and one for z — for each of visual layers that made up the parallax effect. Obviously I had discovered this meant more processing than many of the browsers were happy with, but it definitely meant much simpler CSS. This separating method allowed me to easily combine simple transformations, which otherwise all possible combinations would have to have been hard-coded for, because CSS has no way of modifying, combining or inheriting part of a style attribute — there is no way to do this, for instance:

    <div class="x0 y0 z0"></div>

    .z0 { transform: translateZ(-50px); }
    .y0 { transform: translateY(100px); }
    .x0 { transform: translateX(0px); }

The div in the example above will not end up with each of it's translate coordinates set, and instead will only have `translateX` applied. However, if you do the following:

    <div class="z0">
      <div class="y0">
        <div class="x0"></div>
      </div>
    </div>

Then the final child `x-0` will have been affected by each of the translations.


Unfortunately, because of the need to find optimisations and to get around these browser glitches, I was now going to have to try and combine x, y, z coordinates together. This is quite doable with a singular 3d transformation, but not so easy if you want your 90% of site to function without JavaScript, and you want visitors to be able to navigate around in "2.5D" space along each 3D axis separately.


At the time I had just started playing around with LESS, and from what I had read this would have been a good test case for it — using functions to generate the complexity. Sadly, I was also juggling a lot of other things, and found it easier to fit in methodical plodding through manual CSS wiring than creatively building this on the fly. Perhaps v4 of the site will have this.


Bring me that horizon.
(and hopefully less bad eggs)

So after a while of CSS rewiring — and you have to remember these changes were still just a hunch — I had the site back up to a testable standard. And lo, the performance was improved for most browsers, even though the number of CSS rules had more than quadrupled. Here a feel for the number of newly added CSS files, each with over 500+ lines of unminified rules, all this just to get the site's response to navigation working:


    parallax-elements-d0z0.css
    parallax-elements-d0z1.css
    parallax-elements-d0z2.css
    parallax-elements-d1z0.css
    parallax-elements-d1z1.css
    parallax-elements-d1z2.css
    parallax-elements-d2z0.css
    parallax-elements-d2z1.css
    parallax-elements-d2z2.css
    parallax-elements.css


{: .note}
> Thankfully all this added style has a relatively small footprint once it's been aggregated, minified and g-zipped, which thanks to Node.js, Sails.js and Grunt, all happens automagically when I run the site in production mode.


With the above out the way, it turned out that Safari was now the fastest, and Chrome had back-flipped to the bottom of the list. So I rolled back the code I had named "Pixilayer", this was what was responsible for converting the ordinary CSS background images, over to canvas based imagery. Named as such because it was powered by `pixi.js`, just because I was being lazy in writing my own canvas API. Once I did that nearly all the browsers were happy, save for Opera, which still liked to benefit from pixi-layering.


Below you can see a snapshot of the parallax scene, my website is teetering on the edge of being released, so watch this space... Well, not this space, but codelamp.co.uk instead.


