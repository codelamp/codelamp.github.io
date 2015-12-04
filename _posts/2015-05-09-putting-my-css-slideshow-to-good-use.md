---
title: "Putting my CSS Slideshow to good use"
layout: default
metaSubTitle: "Putting my CSS Slideshow to good use"
pid: "css-slideshow-good-usage"
---

{: .header-image}
[![Blog Bg](/images/css-slideshow-header.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

> A while back, as a challenge, I set myself the task of producing a slideshow that didn't require JavaScript. Not only that, I also stipulated a few other specifications:
> <br /><br />
> 
> 1. Offer forward and backward navigation.
> 2. Not modify navigation history.
> 3. Instil a distinct direction to the movement of the content.
> 4. Work across as many browsers as possible.

<!--more-->

{: .side-image}
[![Snapshot of Stackoverflow post](/images/css-only-slideshow.png)](http://stackoverflow.com/questions/21647389/implement-a-css-only-slideshow-carousel-with-next-and-previous-buttons)

It took a while, mainly because certain CSS specifications were still fluctuating and were still being implemented by the user agent magicians. Eventually I got a working version, which I then quickly rewrote. I was rather please with the result so decided to post it as a solution on StackOverflow, just in case it would help out other developers with less time on their hands.

If you are interested you can read it <a href="http://stackoverflow.com/questions/21647389/implement-a-css-only-slideshow-carousel-with-next-and-previous-buttons" target="_blank">here</a>, although a word of warning, it does waffle on a bit. 

Anyway, the reason I mention this here is because I then took that slideshow, simplified it, and used it in several locations within my new site.

This method uses a slightly different way of detecting input from the user, to that of the site's main parallax navigation. Rather than relying on fragment `:targeting`, it uses `:focus` instead. This has the benefit of not modifying the page navigation, so it doesn't create reams upon reams of history states. The downside however is that your slides can't contain any interactive content themselves i.e. like links. This was perfect for my requirements, but does mean you have to chose carefully when best to use this solution.

I chose this solution over another popular approach, one called the "checkbox/radio hack", because I wanted it to work when using the tab key. Groups of radios do allow you to focus the group with the tab key, but then for subsequent navigation within the group, you have to switch to using arrow keys. Which wasn't very intuitive compared to the rest of the site.

