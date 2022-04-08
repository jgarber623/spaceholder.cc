# Contributing to SpaceHolder

I'd love to have your help improving SpaceHolder! If you'd like to pitch in, you can do so in a number of ways:

1. Look through open [Issues](https://github.com/jgarber623/spaceholder.cc/issues).
1. Review any open [Pull Requests](https://github.com/jgarber623/spaceholder.cc/pulls).
1. [Fork SpaceHolder](#get-set-up-to-contribute) and fix an open Issue or add your own feature.
1. File new Issues if you have a good idea or see a bug and don't know how to fix it yourself. _Only do this after you've made sure the behavior or problem you're seeing isn't already documented in an open Issue._

I definitely appreciate your interest in (and help improving) SpaceHolder. Thanks!

## Setup

SpaceHolder is written in [Ruby](https://www.ruby-lang.org) (version 3.1.1) and uses the [Bundler](https://bundler.io) gem to manage Ruby dependencies. Local development is done within a [Docker](https://docker.com) container running a custom-built image.

To get started, install the version of [Docker Desktop](https://www.docker.com/products/docker-desktop/) that's most appropriate for your system. With Docker Desktop installed and running, open a Terminal window and `cd` to your checked out copy of the application and run:

```sh
bin/start --build
```

This command will build a custom Docker image, run a development container using that image, and mount your local copy of the code into the running container. This setup allows you to make changes to the application in your editor of choice and have those changes immediately reflected in the running container.

To run the application in the custom-built Docker container, open a new Terminal tab and run:

```sh
bin/exec bin/run
```

The `bin/exec` script will forward any commands sent to it into the running container. For example, if you add a gem, you would run:

```sh
bin/exec bundle install
```

After running `bin/exec bin/run`, you should be able to access the application in a Web browser by loading `http://localhost:8080`.

## Get set up to contribute

Contribute to SpaceHolder by doing the following:

1. Fork the SpaceHolder repo and clone it.
1. Get up and running by following the [setup instructions](#setup) above.
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

SpaceHolder's formatting guidelines are defined in the `.editorconfig` file which uses the [EditorConfig](https://editorconfig.org) syntax. There are [a number of great plugins for a variety of editors](https://editorconfig.org/#download) that utilize the settings in the `.editorconfig` file. Using EditorConfig will make your time spent coding a little bit easier.

Your bug fix or feature addition won't be rejected if it runs afoul of any (or all) of these guidelines, but following the guidelines will definitely make everyone's lives a little easier.
