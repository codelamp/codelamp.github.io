# codelamp.github.io

This is a blog powered by Jekyll for the latest iteration of my business website.

http://v3.codelamp.co.uk

http://blog.codelamp.co.uk

## This blog can be rendered locally

First install ruby via:

```bash
brew install chruby ruby-install xz
ruby-install ruby 3.1.3

gem install jekyll bundler serve # uncertain if this was better via bundler

bundle init
bundle add jekyll # uncertain if this was needed
bundle install

bundle exec jekyll serve
```