---
title: "Horizontal parallax navigation, but without the JavaScript"
layout: default
metaSubTitle: "Horizontal parallax navigation, but without the JavaScript"
---

{: .header-image}
[![Blog Bg](/images/making-of.png)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

> Despite my fondness for JavaScript I've always been a keen advocate of what has now been named "progressive enhancement", put in simple terms, anything that is scripted client-side should really only be a bonus in terms of your site's functionality. 

> Rely on JavaScript, client-side, Websites should not. *Master Yoda*

<!--more-->

So, I tend to take this to heart with my personal websites, and go as far as I can go. Mainly because I don't have a budget to stick to, and can take my time to implement the basics without JavaScript, and then add the script flourishes later.


This also generally gives me a chance to challenge myself, to see if I can achieve what normally might be done with JavaScript, using only CSS instead.


There seem to be a lot of people who will argue against doing overly clever things with CSS, but I tend to ignore them. Mainly because if you keep your cutting-edge CSS separate from your core styles, and you treat your CSS as you would your JavaScript — by making sure your it degrades nicely — then the arguments don't have much of any leg to stand on. Especially if you make certain your fancy features do not interfere with usability or readability.


So it did take a little while, mainly of juggling precedences, and working out quite a complex matrix of CSS transform rules, but I now have a functionally complex website that behaves almost exactly the same whether JavaScript is enabled or not. All thanks to CSS3.


## User interaction

In order to get CSS to handle something as complicated as a parallax navigation, you need to boil things down to the most basic concepts first and work up. Before you can hope to achieve a navigation system in CSS you need a way to flag/track user input, and to have CSS retain that request, at least until another request occurs.

> How can you get CSS to remember a change of state? 

If you know anything of CSS you'll probably know there are a few obvious choices for user input detection, however you may not know some of the others:

    hover state
    focus/active state
    checked state
    target state

Hover state really isn't appropriate here, as it only stays useful whilst the mouse pointer exists, is in use, and is held in the right location. Focus state isn't so great for our purposes either, because the second a user interacts with another focusable element, the target changes. That only leaves checked state and target state.


If you're interested in `:checked` state you can find a number of examples if you search the web for the radio/checkbox hack. I however opted to use the `:target` state because this ties directly to URL fragments, meaning that the user can return to the same page or content state by just bookmarking the current URL, which isn't possible with the radio hack. Basically I wanted to avoid similar scenarios to this comic, which sadly seems to be happening more and more with other — currently rather popular — vertical parallax scroller systems.


## Targeting elements

I'm actually quite a fan of the `:target` selector in CSS3, my only lament is that it only works with IDs and not class names. If you've not come across it before, here is a brief example:

    .element-to-reveal {
      display: none;
    }

    #target-1:target .element-to-reveal-for-target-1 {
      display: block;
    }
    #target-2:target .element-to-reveal-for-target-2 {
      display: block;
    }


    <div id="target-1">
      <div id="target-2">
        <div class="element-to-reveal element-to-reveal-for-target-1"><p>A</p></div>
        <div class="element-to-reveal element-to-reveal-for-target-2"><p>B</p></div>
      </div>
    </div>
    <a data-blogger-escaped-href="#target-1">Target 1</a>
    <a data-blogger-escaped-href="#target-2">Target 2</a>

What will happen with the above is that both `A` and `B` will be invisible, until either `Target 1` or `Target 2` is clicked. `Target 1` will reveal `A`, and `B` will be shown by `Target 2`. This is the basic premise behind my website, although it is made 400% more confusing by introducing multiple layers that translate their transforms at different speeds depending on which target is `:targeted`.

Because this system works with IDs, and any element can only have one ID, if you want to affect the same element with each of your different states you have to wrap that element in as many parents. This would not be required if class names were supported. Unfortunately the fragment part of the URL is directly geared for working with IDs, and I don't see that changing any time soon. All in all this isn't such a bad caveat to deal with, browsers these days make short work of even the deepest of markup — it just looks a bit ugly from the source/debugging perspective.


