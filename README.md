# Changify

[![Licensed under MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE.txt)
[![quality](https://github.com/joeljuca/changify/actions/workflows/main.yml/badge.svg)](https://github.com/joeljuca/changify/actions/workflows/main.yml)
[![Follow Joel Jucá on X (formerly Twitter)](https://img.shields.io/twitter/follow/holyshtjoe)](https://twitter.com/holyshtjoe)

## Setup

Install dependencies with [Bundler](https://bundler.io):

```
$ bundle install
```

## About

My solution for the [BuildBook coding challenge](https://gist.github.com/vitchell/a081703591116bab7e859cc000c98495).

I wrote a Ruby module with the core functionality of this test.

The CLI itself is actually implemented in the `examples/spotify` dir.

## `spotify.rb`

This is the actual CLI, located in the `examples/spotify` dir. To see it in action, do the following

```sh
$ cd examples/spotify
```

See the example in action with sample data:

```sh
$ ruby ./spotify.rb ./deezer.json ./changes.jsonl
```

By default, it prints the resulting JSON to STDOUT. It allow pipelining the results with tools like [jq](https://jqlang.github.io/jq/):

```sh
$ ruby ./spotify.rb ./deezer.json ./changes.jsonl | jq .
```

You can also write the resulting JSON to a destination file:

```sh
$ ruby ./spotify.rb ./deezer.json ./changes.jsonl output.json
```

To eliminate the `ruby` part of this command, adjust its file permissions:

```sh
# set Unix permissions
$ chmod u+x spotify.rb

# now you can execute it without the `ruby` prefix
$ ./spotify.rb ./deezer.json ./changes.jsonl output.json
```

## Code of Conduct

Everyone interacting in the Changify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## License

[MIT](LICENSE.txt)
