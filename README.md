# Slack Messaging [![Maintainability](https://api.codeclimate.com/v1/badges/c74baada70ad96048dc7/maintainability)](https://codeclimate.com/github/emmasax4/slack_messaging/maintainability) ![Develop](https://github.com/emmasax4/slack_messaging/workflows/Develop/badge.svg)

This is a simple project designed to post messages to a given Slack channel as a bot.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_messaging'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_messaging

### Usage

This project requires a config file that should look like this:

```
slack:
  channel: "#<AWESOME CHANNEL NAME>"
  username: <AWESOME USER NAME]>
  webhook_url: <WEBHOOK URL>
  icon_emoji: ":<SOME EMOJI>:"
```

The default is for the file to be named `~/.slack_messaging.yml`, but a different path can be passed in like this:

```
$ slack-messaging --config="/PATH/TO/FILE/config.yml" slack
```

To obtain the webhook url, go to [this link](https://api.slack.com/incoming-webhooks).

Okay, now the project will be ready to rock and roll.

To print a friendly message to Slack, run:

```
slack-messaging slack
```

from the main directory. Here, no specific message is being given to print to Slack, so slack_messaging will choose a random quote, which are all defined in [`lib/slack_messaging/random_message.rb`](https://github.com/emmasax4/slack_messaging/blob/main/lib/slack_messaging/random_message.rb). Feel free to change the messages or add more to cater what you'd like slack_messaging to say.

However, what if you wanted to print something specific? Well, you can! Just run:

```
slack-messaging slack "MESSAGE 1"
```

You can even print multiple messages at once:

```
slack-messaging slack "MESSAGE 1" "MESSAGE 2" "MESSAGE 3" ... "MESSAGE N"
```

The output of slack_messaging will look something like this:

<img src="https://github.com/emmasax4/slack_messaging/blob/main/OutputFile.png" width="1000">

I hope you enjoy printing fun and specialized messages to Slack!

### Tests

To run the tests, run `bundle exec rspec` from the command line. GitHub Actions will also run the tests upon every commit to make sure they're up to date and that everything is working correctly. Locally, you can also run `bundle exec guard` to automatically run tests as you develop! There are currently only tests for the `notify_slack` and `random_message` classes. Feel free to help us add more!

## Contributing

To submit a feature request, bug ticket, etc, please submit an official [GitHub Issue](https://github.com/emmasax4/slack_messaging/issues/new).

To report any security vulnerabilities, please view this project's [Security Policy](https://github.com/emmasax4/slack_messaging/security/policy).

This repository does have a standard [Code of Conduct](https://github.com/emmasax4/slack_messaging/blob/main/.github/code_of_conduct.md).

## Releasing

To make a new release of this gem:

1. Merge the pull request via the big green button
2. Run `git tag vX.X.X` and `git push --tag`
3. Make a new release [here](https://github.com/emmasax4/slack_messaging/releases/new)
4. Run `gem build *.gemspec`
5. Run `gem push *.gem` to push the new gem to RubyGems
6. Run `rm *.gem` to clean up your local repository

To set up your local machine to push to RubyGems via the API, see the [RubyGems documentation](https://guides.rubygems.org/publishing/#publishing-to-rubygemsorg).
