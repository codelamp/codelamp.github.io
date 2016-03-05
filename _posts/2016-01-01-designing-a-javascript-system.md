---
title: "Designing a JavaScript library"
layout: default
metaSubTitle: "Designing a JavaScript library"
pid: "desing-javascript-library"
---

{: .header-image}
[![Blog Bg](/images/theory-js-2.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I've been working towards my Theory.js library for as long as I've been coding JavaScript. For me, it has been the search of how best to code in the rather odd world of a fast and sketchable "scripting" language.

<!--more-->

## If at first you don't succeed...

Part of what makes my level of experience unexpected — at least to those who expect to judge people based upon an A4 sheet of historical information — is something that is true for a great many self-taught coders. When we say we have attempted, built, designed or worked with a system before; it very rarely means we've done it only once.

Many of my personal projects have been rebuilt over and over again — in a multitude of different ways — this is how I test and learn new technologies at home. For example, this has been true for my Pebbl game (5 times), for my Gadgets game (2 times), for ALWTM (3 times) and Theory (7 times). Each time I rework something I gain insights into the language, and the tools I've used.

Theory.js has been recreated every time my JavaScript coding style has substantially changed. Each time I've learned reasons as to why a certain way of doing something works better; So it makes sense to rejig things.

For this article I thought I'd outline some of the choices I made behind Theory.js, and exactly why the way of implementing things makes sense.


## Everything happens through a reference

One of the awkward areas I've seen a number of developers fall in to — with regard to any language, but specifically JavaScript in this case — is with references. This is especially true when references collide with prototype inheritance or constructors.

For example, here's some pseudo code that could describe a general class:

    class Book {
      pages = new List
      addPage(page){
        self.pages.push(page)
      }
      countPages(){
        return count(self.pages);
      }
    }

Now if you were to run the following:

    h2g2 = new Book()
    h2g2.addPage( new PageObject() )
    h2g2.addPage( new PageObject() )

A call to `h2g2.countPages()` would output `2`, as you would expect:

If you were then to create another book:

    salmonOfDoubt = new Book()
    salmonOfDoubt.addPage( new PageObject() )

You would still expect `salmonOfDoubt.countPages()` to output `1`.

Now take the same example in JavaScript, or at least as close as you can get to a "class" without invoking the all new ES6.

    function Book(){};
    Book.prototype.pages = [];
    Book.prototype.addPage = function(page){
      this.pages.push(page);
    };
    Book.prototype.countPages = function(){
      return this.pages.length;
    };

Now invoke the same as above — those who know where I'm going, already know where I'm going ;)

    var h2g2 = new Book();
        h2g2.addPage( {} );
        h2g2.addPage( {} );
    var salmonOfDoubt = new Book();
        salmonOfDoubt.addPage( {} );

Calling `salmonOfDoubt.countPages()` or `h2g2.countPages()` would output `3`.

This is due to the way we have built our Constructor, we've implemented a shared reference in the form of:

    Book.prototype.pages = [];

This means that across `salmonOfDoubt` and `h2g2` the pages array is the same.

This is a fundamental difference between many class-based languages and JavaScript. When you define properties for the "structures" that you will derived instances from, in the class world, these properties are recreated for each instance of the class. In JavaScript, they are just one-off properties attached to an object, and these properties are inherited down the prototype chain.

You can obviously fix this issue in JavaScript, by doing anything similar to the following:

    function Book(){
      this.pages = [];
    };
    // Book.prototype.pages = [];

This change will fix the problem, because for each instance created, the function Book is executed. This means that each time a new instance of book is created a new pages array is attached to it (and each pages array is unique to its book).

### Moving away from construction to Object.create

In all my years of JavaScripting, I have never quite liked the `Object.prototype` / `new Object()` model. So I was rather happy when an alternative appeared. `Object.create` allows you to do the same as the standard model, but — in my opinion — in a simpler (and therefore) neater way. It is much nice to view JavaScript as just a collection of objects that share methods and properties, than attempt to bend its nature to anything else that might be similar.

So instead of the above, we have:

    var Book = {
      pages: [],
      addPage: function(page){
        this.pages.push(page);
      },
      countPages: function(){
        return this.pages.length;
      }
    };
    var h2g2 = Object.create(Book);

This still assigns the same prototype chain, and still achieves a class-like bundle (better referred to as a namespace). However, it does still suffer from the fact that we create shared references. This is why I have built Theory's `t.creator`, which makes use of `Object.create`, but extends it.

### How do references fit in with `t.create`?

The above is one of the reasons why you will see the following when using Theory.js:

    var Book = t.creator({
      prep: function(){
        this.i.pages = [];
      },
      addPage: function(page){
        this.i.pages.push(page);
      },
      countPages: function(){
        return this.i.pages.length;
      }
    });

Basically, whenever an instance of a creator is built, it is automatically assigned its own unique `i` property (`i` for internal). Anything that is assigned to this will only ever be present on this unique instance. You could argue that the following is the same:

    prep: function(){
      this.pages = [];
    }

Which is true in terms of unique references. But the principal behind Theory's Creator system is that everything is shared between instances -- by default -- unless explicitly specified to be unique. This means that it should be assumed that anything that is not placed within `i`, is shared with its base prototype.

There are other benefits to having `.i` too. It makes reusing instances easier.

In certain circumstances it is preferable to keep a pool of already created objects, which are recycled, rather than relying on continually garbage collecting. With Theory, in a well designed Creator, all you need to do is replace, re-initialise or copy the `.i` property to reset or clone an instance. True, this is still consigning an object to be garbage collected, however the unique properties are usually a subset -- compared to the number methods. If you also include that some objects can take a bit to set-up, you save all this processing work.

To be continued ...