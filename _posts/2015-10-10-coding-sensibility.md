---
title: "Coding sensibility"
layout: default
metaSubTitle: "Coding sensibility"
pid: "coding-sensibility"
---

{: .header-image}
[![Hot Metal](/images/hot-metal.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I have spent a number of years throughout my professional coding life, trying to avoid something that I have never really described to anyone. It is possible that many people already understand the concept that I am trying to explain. They may even have some quotable agile buzz word to describe exactly what it is &mdash; but considering I am self taught, I will attempt to illustrate it in my own way. I will also detail why I have given up trying to escape this constant outcome, and instead learned to accept it as necessary.
> <br />
> <br />
> Put simply, whenever I code : it feels like I am working with <i>hot metal</i>.

<!--more-->

## Huh?
This may sound a strange thing to say, especially to those who may place Blacksmiths and Coders in different boxes. But to me it accurately describes the process that occurs when working on any piece of source code.

When dealing with any aspect of a system, you get to know that part of the system well.&nbsp; And my brain particularly responds well to focusing on particular areas until they feel "right". The sense of correctness is rather difficult to explain, but it seems to come out of aligning whatever I am currently working on, with its specifications, against a backdrop of "contemporary" best practices; for that whichever language I am using.

This process ties in heavily with the way my memory behaves, so it could be quite different for other people.

The way my memory works, in terms of coding, is very much split across short term and long term. It really does take a while for me to forget code that I have worked on, however, it does not take long at all for me to forget how I can safely rework / rearrange / refactor the code without causing issues or missing something.

Put directly, my understanding of the code hardens over time... it becomes less flexible.

That is until I decide to refactor it again.

This whole process is obviously directly affected by the fact that every project I undertake changes my outlook on my own coding style and habits, which means I nearly always look back differently on (even recently) old code. 

## Solutions?
I have attempted many ways to avoid this problem, mainly because it directly affects how systems can be built. Refactoring constantly is very time consuming, but if you are working in a new territory it is almost impossible to avoid. Especially if you want to end up with a good, well-structured product.

If you could return to any section of a coding project, pick it back up quickly from exactly where you left off — whilst having your work in other areas re-align themselves as you make changes — then you could build almost anything with a very small team of developers.

> Unfortunately this is extremely hard to do. 

Some solutions — that the entire coding community have tried — might be rather obvious, "well commented code" would be an example. Whilst commenting code helps no end with understanding individual snippets. And possibly even comprehending the mindset of said coder at the time. It rarely helps understand the structure and interplay of the separate pieces, and definitely doesn't help my particular brain "reload" what exactly how it was thinking before. Commenting also doesn't help with having surrounding code modify itself to your new changes.

Automated tests would be another possible solution. Whilst having tests definitely does help, they also bring their own problems. They slow down development, and unless very well thought out — they become just as brittle as the aforementioned "cooled" code. Still, I don't think I would attempt to work on a large-scale site without them these days. They do make deployments a lot less stressful.

API Documentation would also help. I haven't really attempted this one much myself. I have just started getting to grips with the likes of JSDoc, which is definitely helping to give an overview feel of the current coding project. It can also help bring all your TODO statements into one readable place.

The final item isn't at all obvious to me, and I still find goes against the grain, but it is a key piece of advice that has been given to me by a few of my coding mentors over the years.

> Things cannot be perfect.

Unfortunately for me, if I hadn't refactored quite so much, I would never have learned as much as I have about coding. So I am still very keen to refactor. For client code I do avoid the urge as much as possible. However there isn't any such thinking in place to save me from myself, when dealing with my own projects.