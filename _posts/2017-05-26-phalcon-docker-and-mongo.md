---
title: "Phalcon, Docker and Mongo"
layout: default
metaSubTitle: "Phalcon, Docker, and Mongo"
pid: "phalcon-docker-mongo"
---

{: .header-image}
[![Blog Bg](/images/falcon-docker-mongo.jpg)]({{page.url}})

# {{ page.title | windowprotect }}

{: .date}
## {{page.date | date: "%A %-d %B %Y"}}

{: .standfirst}
> As part of my recent experiments and research, I have been looking certain technologies that have caught my eye over the last year. Always keen to find a "More Betterer" &trade; arrow to add to my bow, or a better bow, or even a better concentric target rings... I thought I would checkout two key pieces of technology together. Phalcon and Docker.

<!--more-->

<strong>Phalcon</strong> — <em>an open source, full stack framework for PHP written as a C-extension</em> — and <strong>Docker</strong> — a Whale playing Tetris, (or as they prefer to put it: <em>an open platform for developers and sysadmins to build, ship, and run distributed applications</em>) — have been on my radar for a while, but I've not had a chance to test them out.

## VirtualBox vs Docker

I've been using Vagrant and VirtualBox on and off for years, for different parts of projects. For instance, we used them at Tate to build the Python/Django replacement for the Art &amp; Artist section. For that project, and many others, the system has worked well... however, there have always been issues to overcome.

1. If you need to create systems that interconnect, that perhaps would live on separate servers, the provisioning and inter-communication configuration becomes a lot trickier.
2. This may have been resolved by the community now (I've haven't had the need to check recently) but in the past I've had a number of issues with the speed of the Shared folders for Virtual box.
3. The drain on the host system once you start running multiple VMs can be prohibitive, so much so, that you start making your choices in terms of architecture linked to what you can run locally.

This is where Docker comes in. I always read a lot tech articles, and had obviously come across the fact that Docker has been specifically designed to avoid specifically point 1 and 3. So a definitely good reason to check it out.

## Phalcon

In development, speed means you can do more. In business, it tends to mean you can sell more. In HR, it probably means there's a problem somewhere.

Whatever you build these days, (excluding putting together your project's team), it had better be fast.

Node took off because it was unique, and well thought-out, but also because for certain tasks, it was faster than anything else available.

This was probably a call to arms for those who code in slightly lower-level/secretive languages than front-end scripters ;) because now it seems every technology ecosystem (new and old alike) are broadcasting how fast their <em>&lt;INSERT YOUR LANGUAGE, FRAMEWORK HERE&gt;</em> operates.

Phalcon is no exception, but then something deserves to call itself "fast" if it is compiled in C. Which was exactly how it was sold to me by a fellow developer. Being someone who has dabbled with Assemble, C++, and then C# — I was keen to find out what would be possible using a web framework that might allow you to mix high-level with low-level.

## Getting started

As is so often the case these days, whatever you search for, you can generally find a project that someone has put together... usually on GitHub. Which is a godsend for those with diminishing hours of daylight. So after trying a few repos I had found, to no avail, I came across the following:

[https://github.com/phalcon/phalcon-compose](https://github.com/phalcon/phalcon-compose){:.external}

Which after a little bit of finagling the configurations, I managed to get up and running pretty quickly. After doing this, I set about the task of actually understanding what had been done by trying to recreate parts from scratch. There is no substitute for learning by taking to the time to bumble around, mess things up, and then debug.

My only complaint for the above repo, is that its documentation is a bit thin on the ground. Basically I think it assumes you already know quite a bit about Docker and, more specifically, `docker-compose`.

For those who, like me, where just getting up to speed, here are a few commands that may be useful.

### Controlling your app

Once you have the root directory created, it should look something like this:

<div id="folder_structure"></div>
<noscript class="script-later">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script>
  (function(){
    var tree = [
      {
        "path": "./.editorconfig",
        "text": ".editorconfig",
        "icon": "jstree-file"
      },
      {
        "path": "./.gitattributes",
        "text": ".gitattributes",
        "icon": "jstree-file"
      },
      {
        "path": "./.gitignore",
        "text": ".gitignore",
        "icon": "jstree-file"
      },
      {
        "path": "./.rspec",
        "text": ".rspec",
        "icon": "jstree-file"
      },
      {
        "path": "./.travis.yml",
        "text": ".travis.yml",
        "icon": "jstree-file"
      },
      {
        "path": "./Gemfile",
        "text": "Gemfile",
        "icon": "jstree-file"
      },
      {
        "path": "./Gemfile.lock",
        "text": "Gemfile.lock",
        "icon": "jstree-file"
      },
      {
        "path": "./LICENSE.txt",
        "text": "LICENSE.txt",
        "icon": "jstree-file"
      },
      {
        "path": "./Makefile",
        "text": "Makefile",
        "icon": "jstree-file"
      },
      {
        "path": "./README.md",
        "text": "README.md",
        "icon": "jstree-file"
      },
      {
        "path": "./Rakefile",
        "text": "Rakefile",
        "icon": "jstree-file"
      },
      {
        "path": "./application",
        "text": "application",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./application/cache",
            "text": "cache",
            "type": "folder",
            "children": [

            ]
          },
          {
            "path": "./application/logs",
            "text": "logs",
            "type": "folder",
            "children": [

            ]
          },
          {
            "path": "./application/public",
            "text": "public",
            "type": "folder",
            "children": [
              {
                "path": "./application/public/Documents",
                "text": "Documents",
                "type": "folder",
                "children": [
                  {
                    "path": "./application/public/Documents/Project.php",
                    "text": "Project.php",
                    "icon": "jstree-file"
                  }
                ]
              },
              {
                "path": "./application/public/Hydrators",
                "text": "Hydrators",
                "type": "folder",
                "children": [
                  {
                    "path": "./application/public/Hydrators/DocumentsProjectHydrator.php",
                    "text": "DocumentsProjectHydrator.php",
                    "icon": "jstree-file"
                  }
                ]
              },
              {
                "path": "./application/public/bootstrap.php",
                "text": "bootstrap.php",
                "icon": "jstree-file"
              },
              {
                "path": "./application/public/composer.json",
                "text": "composer.json",
                "icon": "jstree-file"
              },
              {
                "path": "./application/public/composer.lock",
                "text": "composer.lock",
                "icon": "jstree-file"
              },
              {
                "path": "./application/public/index.php",
                "text": "index.php",
                "icon": "jstree-file"
              },
              {
                "path": "./application/public/vendor",
                "text": "vendor",
                "type": "folder",
                "children": [
                  {
                    "path": "./application/public/vendor/alcaeus",
                    "text": "alcaeus",
                    "type": "folder",
                    "children": [
                      {
                        "path": "./application/public/vendor/alcaeus/mongo-php-adapter",
                        "text": "mongo-php-adapter",
                        "type": "folder"
                      }
                    ]
                  },
                  {
                    "path": "./application/public/vendor/autoload.php",
                    "text": "autoload.php",
                    "icon": "jstree-file"
                  },
                  {
                    "path": "./application/public/vendor/composer",
                    "text": "composer",
                    "type": "folder",
                    "children": [
                      {
                        "path": "./application/public/vendor/composer/ClassLoader.php",
                        "text": "ClassLoader.php",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/LICENSE",
                        "text": "LICENSE",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/autoload_classmap.php",
                        "text": "autoload_classmap.php",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/autoload_files.php",
                        "text": "autoload_files.php",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/autoload_namespaces.php",
                        "text": "autoload_namespaces.php",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/autoload_psr4.php",
                        "text": "autoload_psr4.php",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/autoload_real.php",
                        "text": "autoload_real.php",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/autoload_static.php",
                        "text": "autoload_static.php",
                        "icon": "jstree-file"
                      },
                      {
                        "path": "./application/public/vendor/composer/installed.json",
                        "text": "installed.json",
                        "icon": "jstree-file"
                      }
                    ]
                  },
                  {
                    "path": "./application/public/vendor/doctrine",
                    "text": "doctrine",
                    "type": "folder",
                    "children": [
                      {
                        "path": "./application/public/vendor/doctrine/annotations",
                        "text": "annotations",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/cache",
                        "text": "cache",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/collections",
                        "text": "collections",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/common",
                        "text": "common",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/inflector",
                        "text": "inflector",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/instantiator",
                        "text": "instantiator",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/lexer",
                        "text": "lexer",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/mongodb",
                        "text": "mongodb",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/doctrine/mongodb-odm",
                        "text": "mongodb-odm",
                        "type": "folder"
                      }
                    ]
                  },
                  {
                    "path": "./application/public/vendor/mongodb",
                    "text": "mongodb",
                    "type": "folder",
                    "children": [
                      {
                        "path": "./application/public/vendor/mongodb/mongodb",
                        "text": "mongodb",
                        "type": "folder"
                      }
                    ]
                  },
                  {
                    "path": "./application/public/vendor/psr",
                    "text": "psr",
                    "type": "folder",
                    "children": [
                      {
                        "path": "./application/public/vendor/psr/log",
                        "text": "log",
                        "type": "folder"
                      }
                    ]
                  },
                  {
                    "path": "./application/public/vendor/symfony",
                    "text": "symfony",
                    "type": "folder",
                    "children": [
                      {
                        "path": "./application/public/vendor/symfony/console",
                        "text": "console",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/symfony/debug",
                        "text": "debug",
                        "type": "folder"
                      },
                      {
                        "path": "./application/public/vendor/symfony/polyfill-mbstring",
                        "text": "polyfill-mbstring",
                        "type": "folder"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "path": "./bin",
        "text": "bin",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./bin/logs.sh",
            "text": "logs.sh",
            "icon": "jstree-file"
          }
        ]
      },
      {
        "path": "./cache",
        "text": "cache",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./cache/.gitignore",
            "text": ".gitignore",
            "icon": "jstree-file"
          }
        ]
      },
      {
        "path": "./composer.json",
        "text": "composer.json",
        "icon": "jstree-file"
      },
      {
        "path": "./conf",
        "text": "conf",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./conf/php",
            "text": "php",
            "type": "folder",
            "children": [
              {
                "path": "./conf/php/cli.ini",
                "text": "cli.ini",
                "icon": "jstree-file"
              },
              {
                "path": "./conf/php/fpm.ini",
                "text": "fpm.ini",
                "icon": "jstree-file"
              }
            ]
          }
        ]
      },
      {
        "path": "./data",
        "text": "data",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./data/mysql",
            "text": "mysql",
            "type": "folder",
            "children": [
              {
                "path": "./data/mysql/.gitkeep",
                "text": ".gitkeep",
                "icon": "jstree-file"
              }
            ]
          }
        ]
      },
      {
        "path": "./docker",
        "text": "docker",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./docker/app",
            "text": "app",
            "type": "folder",
            "children": [
              {
                "path": "./docker/app/Dockerfile",
                "text": "Dockerfile",
                "icon": "jstree-file"
              },
              {
                "path": "./docker/app/bin",
                "text": "bin",
                "type": "folder",
                "children": [
                  {
                    "path": "./docker/app/bin/fix-permissions.sh",
                    "text": "fix-permissions.sh",
                    "icon": "jstree-file"
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "path": "./docker-compose.yml",
        "text": "docker-compose.yml",
        "icon": "jstree-file"
      },
      {
        "path": "./logs",
        "text": "logs",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./logs/.gitignore",
            "text": ".gitignore",
            "icon": "jstree-file"
          }
        ]
      },
      {
        "path": "./spec",
        "text": "spec",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./spec/localhost",
            "text": "localhost",
            "type": "folder",
            "children": [
              {
                "path": "./spec/localhost/docker_image_spec.rb",
                "text": "docker_image_spec.rb",
                "icon": "jstree-file"
              }
            ]
          },
          {
            "path": "./spec/spec_helper.rb",
            "text": "spec_helper.rb",
            "icon": "jstree-file"
          }
        ]
      },
      {
        "path": "./variables.env",
        "text": "variables.env",
        "icon": "jstree-file"
      },
      {
        "path": "./variables.env.example",
        "text": "variables.env.example",
        "icon": "jstree-file"
      },
      {
        "path": "./vendor",
        "text": "vendor",
        "type": "folder",
        "state": { "opened": true },
        "children": [
          {
            "path": "./vendor/autoload.php",
            "text": "autoload.php",
            "icon": "jstree-file"
          },
          {
            "path": "./vendor/composer",
            "text": "composer",
            "type": "folder",
            "children": [
              {
                "path": "./vendor/composer/ClassLoader.php",
                "text": "ClassLoader.php",
                "icon": "jstree-file"
              },
              {
                "path": "./vendor/composer/autoload_classmap.php",
                "text": "autoload_classmap.php",
                "icon": "jstree-file"
              },
              {
                "path": "./vendor/composer/autoload_namespaces.php",
                "text": "autoload_namespaces.php",
                "icon": "jstree-file"
              },
              {
                "path": "./vendor/composer/autoload_psr4.php",
                "text": "autoload_psr4.php",
                "icon": "jstree-file"
              },
              {
                "path": "./vendor/composer/autoload_real.php",
                "text": "autoload_real.php",
                "icon": "jstree-file"
              }
            ]
          }
        ]
      }
    ];
    var iid = setInterval(function(){
      if ( jQuery.jstree ) {
        clearInterval(iid);
        jQuery('#folder_structure').jstree({ core: { data: tree } });
      }
    }, 50);
  })();
</script>
</noscript>

First up, you need to make sure you edit the `variables.env` file, and make environment changes that align to your specific configuration.

I also found that when running the full suite of included services, performance was atrocious (loading a simple phpinfo() page took 20s+) on my MacBook Pro (Retina, 15-inch, Late 2013). This may be because I'm still running Yosemite, and perhaps a particular dependency didn't like it, or it could be something completely different. I have yet to investigate properly. Whatever it was, it was attempting to convince my laptop that it could fly, using only the power of its internal fans — which is never a good idea.

I didn't need the full suite however, I was only really interested in getting a basic stack up, so I commented out everything save for `mysql` and `mongo` in the `services` and `volumes` definitions found inside `docker-compose.yml` (not forgetting to also comment out the removed services from the `depends_on` key inside the `app` service.

The default configuration for the app ports, found in `docker-compose.yml` also had to be changed — because I already had port 80 in use, so I switched it to `8009`

    app:
      build: docker/app
      restart: always
      working_dir: /project
      ports:
        - "8009:80"
        - "443:443"
      ...

Once that had be done I could rerun the containers using:

    docker-compose up -d

Now on visiting `http://0.0.0.0:8009` I could view the evaluated index.php file found in `./application/public` which meant I was able to actually start coding with Phalcon — without needing to install anything directly on my host machine. Nice.

### Interacting with Mongo

For my next step, I did something foolish. I didn't read Phalcon's documentation correctly, and made an assumption. If I had taken the time to read correctly, I would have noticed that Falcon comes with its own Database ORM that can interrogate MongoDB instances. Instead I only read briefly and learned that Phalcon's ORM was designed to work with MySQL... Which wasn't Mongo, like I wanted. So, I went ahead and started to pull in and configure `doctrine/mongodb-odm`, along with `alcaeus/mongo-php-adapter` for PHP7 support.

It took a bit of time, which I'll never be getting back. However, I did get it working, I created my own collections and got them to persist successfully. I also learned a lot about the construction of the containers, and how to configure Doctrine's Mongo DocumentManager, which is all useful stuff. But I think next time I'll be a bit more thorough in my pre-configuration reading.