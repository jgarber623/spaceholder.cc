# Contributing to SpaceHolder

I'd love to have your help improving SpaceHolder! If you'd like to pitch in, you can do so in a number of ways:

1. Look through open [Issues](https://github.com/jgarber623/spaceholder.cc/issues).
1. Review any open [Pull Requests](https://github.com/jgarber623/spaceholder.cc/pulls).
1. [Fork SpaceHolder](#get-set-up-to-contribute) and fix an open Issue or add your own feature.
1. File new Issues if you have a good idea or see a bug and don't know how to fix it yourself. _Only do this after you've made sure the behavior or problem you're seeing isn't already documented in an open Issue._

I definitely appreciate your interest in (and help improving) SpaceHolder. Thanks!

## Setup

SpaceHolder is written in [Ruby](https://www.ruby-lang.org) (version 2.5.1) and uses the [Bundler](http://bundler.io) gem to manage dependencies. SpaceHolder uses the [libvips](https://github.com/jcupitt/libvips) image processing library to dynamically resize images based on the request URL. Interaction with this library is handled by the [ruby-vips](https://github.com/jcupitt/ruby-vips) binding and the [image_processing](https://github.com/janko-m/image_processing) gem.

### Installing development dependencies

If you're comfortable compiling libvips and its dependencies by hand and/or if you have luck using the [Homebrew-supplied vips Formula](https://github.com/Homebrew/homebrew-core/blob/master/Formula/vips.rb), you may be able to get SpaceHolder running locally by:

1. Installing Ruby 2.5.1 using your method of choice (e.g. [rbenv](https://github.com/rbenv/rbenv), [chruby](https://github.com/postmodern/chruby), [RVM](https://rvm.io))
1. Installing Bundler: `gem install bundler`
1. Running `bundle install`,
1. Starting the application with `bin/shotgun --host 0.0.0.0`, and
1. Navigating to `http://localhost:9393` in your Web browser of choice.

**Alternatively**, you can build and run a [Docker](https://www.docker.com) container with all the necessary dependencies already configured and installed:

1. Install Docker using the most appropriate method for your system (e.g. [Docker for Mac](https://www.docker.com/docker-mac)),
1. Run Docker (which can be done by opening Docker for Mac),
1. Open your Terminal application and `cd /path/to/spaceholder.cc`, and
1. Run `make build` from the root of the project.

The `make build` command (specified in [`Makefile`](https://github.com/jgarber623/spaceholder.cc/blob/master/Makefile)) will pull the appropriate Ruby image from [Docker Hub](https://hub.docker.com) and build the `spaceholder.cc` image using the instructions in [`Dockerfile`](https://github.com/jgarber623/spaceholder.cc/blob/master/Dockerfile). The build may take some time, so be patient, go for a walk, or grab a beverage. Once complete, run `make run` to start up the application. You may then navigate to `http://localhost:9393` using your Web browser of choice.

Most changes to files in `/path/to/spaceholder.cc` will be reflected in the running application. Changes to application dependencies (e.g. adding, removing, or updating gems) will likely require rebuilding the `spaceholder.cc` Docker image using `make build`.

## Get set up to contribute

Contributing to SpaceHolder is pretty straightforward:

1. Fork the SpaceHolder repo and clone it.
1. Install development dependencies by running `bundle install` from the root of the project.
1. Create a feature branch for the issue or new feature you're looking to tackle: `git checkout -b your-descriptive-branch-name`.
1. _Write some code!_
1. Commit your changes: `git commit -am 'Add some new feature or fix some issue'`.
1. Push the branch to your fork of SpaceHolder: `git push origin your-descriptive-branch-name`.
1. Create a new Pull Request and I'll give it a look!

## Code Style

Code styles are like opinions: Everyone's got one and yours is better than mine. Here's how SpaceHolder should be written:

- Use two spaces for indentation.
- No trailing whitespace and blank lines should have whitespace removed.
- Prefer single quotes over double quotes unless interpolating.
- Follow the conventions you see in the existing source code as best as you can.

SpaceHolder's formatting guidelines are defined in the `.editorconfig` file which uses the [EditorConfig](http://editorconfig.org) syntax. There are [a number of great plugins for a variety of editors](http://editorconfig.org/#download) that utilize the settings in the `.editorconfig` file. Using EditorConfig will make your time spent coding a little bit easier.

Your bug fix or feature addition won't be rejected if it runs afoul of any (or all) of these guidelines, but following the guidelines will definitely make everyone's lives a little easier.
