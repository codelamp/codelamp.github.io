---
title: "2d terrain generation, fixes and additional features"
layout: default
metaSubTitle: "2D terrain generation, part 2"
pid: "2d-terrain-gen-2"
---

{: .header-image}
[![Blog Bg](/images/2d-terrain-2-1.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> I've updated the landscape generation code I'm working towards for ALWTM. There were a few bugs with the original code, and
> it needed refactoring in placed (in order to make things more portable). Read my [previous article]({% post_url 2016-05-05-2d-terrain-generation %}){:.internal} to know more about the implementation with Canvas and PIXI.js.

<!--more-->

## first up, bug fixes and refactor

There were a number of little glitches where the individual `PIXI.Rope` segments wouldn't correctly connect. This was just due to missing points at one edge of the generated terrain data.

The refactor just involved a tidy-up of the code, that should have happened before now — just never enough free time. As usual, this involved:

- Creating individual namespaces to house code that could be generalised.
- Removing superflous or rewriting bulky code — I seem to spend more time these days simplifying more than anything else.
- Changing hardcoded values to that of parameters.

There is still more work to be done, considering the original `landscape.js` was a quick prototype, and much of the code is not in namespace/module form.

## additional features

I've ticked a few more items off my todo list, not quite everything yet though:

<dl>
<dt class="done">&#10003;</dt><dd>Allowed for blending textures using a mixture of Vanilla canvas handling and PIXI.RenderTexture.</dd>
<dt class="done">&#10003;</dt><dd>Packaged the segment code for reuse to generated Landscape segments contiguously.</dd>
<dt class="done">&#10003;</dt><dd>To be contiguous, the system needed to align/blend the start of one segment into the next.</dd>
</dl>

Still yet to complete:

<dl>
<dt class="todo">&#10007;</dt><dd>Fully finish refactor so that call code is bundled under particular namespace(s).</dd>
<dt class="todo">&#10007;</dt><dd>Finalise destructible landscapes, either using polygon deformation, or canvas alpha masks.</dd>
<dt class="todo">&#10007;</dt><dd>Add support for adornment atlases, so that the landscape can also populate with game assets.</dd>
</dl>

### gradient masks

The above meant implementing a few more namespaces. For example the following is the code used to generate the horizontal gradient, that is then used as a mask to fade one texture to another.

    /**
     * Create linear horizontal/vertical gradients
     *
     * @namespace gradient
     */
    var gradient = {
      /**
       * Create an instance of gradient
       *
       * @param {Object} options - an object of options
       * @param {Number} options.width - the width dimension of the generated gradient image
       * @param {Number} options.height - the height dimension of the generated gradient image
       * @param {Array.<Array>} [options.stops] - an array of arrays e.g. [[0,'#000'],[1,'#F00']]
       * @param {String} [options.from] - a starting colour, only used if options.stops is not provided
       * @param {String} [options.to] - an ending colour, only used if options.start is provided
       */
      create: function(){
        return this.prep.apply(Object.create(this), arguments);
      },
      prep: function(options){
        this.canvas = document.createElement('canvas');
        this.canvas.width = options.width;
        this.canvas.height = options.height;
        this.canvas.style.width = options.width + 'px';
        this.canvas.style.height = options.height + 'px';
        this.ctx = this.canvas.getContext('2d');
        if ( options.type == 'vertical' ) {
          this.gradient = this.ctx.createLinearGradient(0, 0, 0, options.height);
        }
        else {
          this.gradient = this.ctx.createLinearGradient(0, 0, options.width, 0);
        }
        if ( options.stops ) {
          for ( var i=0; i<options.stops.length; i++ ) {
            this.gradient.addColorStop.apply(this.gradient, options.stops[i]);
          }
        }
        else if ( options.from && options.to ) {
          this.gradient.addColorStop(0, options.from);
          this.gradient.addColorStop(1, options.to);
        }
        this.ctx.fillStyle = this.gradient;
        this.ctx.fillRect(0, 0, options.width, options.height);
        return this;
      },
      getCanvas: function(){
        return this.canvas;
      },
      getAsTexture: function(){
        return PIXI.Texture.fromCanvas(this.canvas);
      },
      addTo: function(target){
        target.appendChild(this.canvas);
      }
    };

### Texture as Canvas

In order to facilitate the skin merge, a mix of both PIXI and Vanilla Canvas coding was needed. This is because PIXI doesn't seem to support Alpha Masks for the Canvas renderer (because it uses a WebGL filter to handle this). Whilst I probably could switch to the WebGL rendering context, I wanted this landscape generator to be as supported as possible. It is more than likely I will switch to using this code as part of a build process or pre-render, in which case, wide support won't be a factor — but for now I'd like to see how far I can get without needing to do that.

The following namespace takes a `PIXI.Texture` and outputs it to a simple Canvas Element.

    var textureAsCanvas = {
      create: function(){
        return this.prep.apply(Object.create(this), arguments);
      },
      prep: function(src){
        if ( !src.texture ) { return; }
        this.renderer = new PIXI.CanvasRenderer(src.texture.width, src.texture.height, {
          transparent: true
        });
        this.sprite = new PIXI.Sprite(src.texture);
        this.container = new PIXI.Container();
        this.container.addChild(this.sprite);
        this.renderer.render(this.container);
        return this;
      },
      getCanvas: function(){
        return this.renderer ? this.renderer.view : null;
      }
    };

### Texture Merge

When I first thought about doing this, I though the cross fading of textures would be the easier part. Oddly however, it turned out not to be, mainly due to the WebGL limitation of masks for PIXI. So I rolled my own, which of course, took a bit more time. My initial idea had been that I would render multiple different landscapes and then layer and fade them. But I quickly realised this involved a lot more processing and wasted time. So instead, I worked directly with the skin textures themselves, fading them first, before building the landscape — this obviously made a lot more sense.

The benefit with this approach is that I can also apply different kinds of transitions to the skins, especially if I am using a Alpha mask. So specific skins could come with their one transition mask, which would help them look less 'generated' when merged to the next texture.

    /**
     * Take a and b inputs as either Canvas or PIXI.Texture and merge in different ways
     */
    var textureMerge = {
      types: {},
      create: function(){
        return this.prep.apply(Object.create(this), arguments);
      },
      prep: function(options){
        this.i = {};
        this.options(options);
        this.triggerType();
        return this;
      },
      options: function(options){
        this.i.options = options;
        if ( !this.i.options.type ) {
          this.i.options.type = 'hfade';
        }
      },
      triggerType: function(){
        if ( this.types[this.i.options.type] ) {
          this.types[this.i.options.type].call(this, this.i.options);
        }
      },
      prepBasic: function(opts){
        this.canvas = document.createElement('canvas');
        this.ctx = this.canvas.getContext('2d');
        this.canvas.width = opts.width;
        this.canvas.height = opts.height;
      },
      prepFromTextureMerge: function(tm){
        this.canvas = tm.canvas;
        this.ctx = tm.ctx;
      },
      getCanvas: function(){
        return this.canvas;
      },
      getAsTexture: function(){
        return PIXI.Texture.fromCanvas(this.canvas);
      },
      aAsCanvas: function(){
        var a = this.i.options.a;
        if ( a.texture ) {
          return textureAsCanvas.create(a).getCanvas();
        }
        else if ( String(a.nodeName).toLowerCase() == 'img' ){
          // @TODO:
        }
        else if ( String(a.nodeName).toLowerCase() == 'canvas' ){
          return a;
        }
      },
      bAsCanvas: function(){
        var b = this.i.options.b;
        if ( b.texture ) {
          return textureAsCanvas.create(b).getCanvas();
        }
        else if ( String(b.nodeName).toLowerCase() == 'img' ){
          // @TODO:
        }
        else if ( String(b.nodeName).toLowerCase() == 'canvas' ){
          return b;
        }
      }
    };

You'll notice that whenever I construct a particular JavaScript object, I do so in a rather specific way. This particular pattern and behaviour has been developed over my 20 years of ECMAScripting — I much prefer it to nearly any other JavaScript construction, as it has a number of benefits. If you'd like to have your eyes-glazed-over and ears bored off, ask me about it some day.

For me, coding has always been about the structure and pattern that is created, and I'm always searching for better ways to make more beautiful, tessellating, stackable, sketch-able, readable and transmittable constructions. Unfortunately, in these days of everyone wanting the 'web' to magically improve their bottom line, the elegance gets lost. What many fail to realise however, is that with elegance comes power, speed and extensibility — and even better ideas.

Anyway, I mention this pattern because — following on from the work on my Theory library — the `textureMerge` namespace is extended by extra pluggable named functions. These functions live under the `types` collection. An example would be the `hfade` extension, this is responsible for horizontally fading one texture into the next, and recursively depends on calling `textureMerge` for other processes:

    /**
     * hfade will merge a and b fading horizontally
     */
    textureMerge.types.hfade = function(options){
      var a = this.aAsCanvas();
      var b = this.bAsCanvas();
      var g = {
        from: 'rgba(0,0,0,0)',
        to: 'white',
        width: Math.max(a.width, b.width),
        height: Math.max(a.height, b.height)
      };
      if ( options.pattern ) {
        g.stops = [];
        for ( var i=0, itm; i<options.pattern.length; i++ ) {
          itm = options.pattern[i];
          g.stops.push([
            itm[0], 'rgba(255,255,255,' + parseFloat(itm[1], 10) + ')'
          ]);
        }
      }
      else {
        g.stops = [
          [0, 'rgba(255,255,255,0)'],
          [0.4, 'rgba(255,255,255,0)'],
          [0.6, 'rgba(255,255,255,1)'],
          [1, 'rgba(255,255,255,1)']
        ];
      }
      options
      // create the horizontal gradient
      var cf = gradient.create(g);
      // merge the gradient and a source
      var af = textureMerge.create({
        type: 'amask',
        a: cf.getCanvas(),
        b: a
      });
      // then overlay the gradient and source on top of b
      var c = textureMerge.create({
        type: 'layer',
        a: b,
        b: af.getCanvas()
      });
      // import the canvas information from c to this
      this.prepFromTextureMerge(c);
    };

The reason for exploding the code in this manner, is that it becomes very easy to add new abilities. And by designing the code to be recursive (always painting to a canvas), the output can then be fed into the input. The simpler you can make your code and functions (always working on singular inputs and outputs) the more pluggable it becomes, and the more fluidic and readable your system becomes — as long as you stick to nice readable namespaces.

To see an example of this fade code in action, click the "Mixed" tab below.

<div class="use-easytabs">
  <ul class="nav nav-tabs">
    <li class=""><a href="#iframe-grass">(old) Grass Texture</a></li>
    <li class=""><a href="#iframe-cracked" class="">Cracked</a></li>
    <li class=""><a href="#iframe-stone" class="">Stone</a></li>
    <li class=""><a href="#iframe-shadow" class="">Mixed</a></li>
    <li class="" onclick="document.querySelector('#iframe-random iframe').src += '';"><a href="#iframe-random" class="">Random (on tab click)</a></li>
  </ul>
  <div class="panels" style="">
    <div id="iframe-grass" style="display: block;" class="active">
      <iframe src="https://v4.codelamp.co.uk/create-spritesheet/landscape.html?seed=bumpy" style="width: 100%; height: 300px;"></iframe>
    </div>
    <div id="iframe-stone" style="display: block;" class="active">
      <iframe src="https://v4.codelamp.co.uk/create-spritesheet/landscape.html?seed=bumpy&tex=stoneTexture" style="width: 100%; height: 300px;"></iframe>
    </div>
    <div id="iframe-cracked" style="display: block;" class="active">
      <iframe src="https://v4.codelamp.co.uk/create-spritesheet/landscape.html?seed=bumpy&tex=crackedTexture" style="width: 100%; height: 300px;"></iframe>
    </div>
    <div id="iframe-shadow" style="display: none; position: static; visibility: visible;" class="">
      <iframe src="https://v4.codelamp.co.uk/create-spritesheet/landscape.html?seed=bumpy&tex=grassTexture&tex2=crackedTexture" style="width: 100%; height: 300px;"></iframe>
    </div>
    <div id="iframe-random" style="display: none; position: static; visibility: visible;" class="">
      <iframe src="https://codelamp.co.uk/blog/generation/landscape.html" style="width: 100%; height: 300px;"></iframe>
    </div>
  </div>
</div>
