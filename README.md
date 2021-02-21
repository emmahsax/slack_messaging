# Slack Messaging [![Maintainability](https://api.codeclimate.com/v1/badges/c74baada70ad96048dc7/maintainability)](https://codeclimate.com/github/emmahsax/slack_messaging/maintainability) ![Default](https://github.com/emmahsax/slack_messaging/workflows/main.yml/badge.svg)

This is a simple project designed to post messages to a given Slack channel as a bot.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_messaging'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install slack_messaging
```

### Usage

This project requires a config file that should look like this:

```
slack:
  channel: <AWESOME CHANNEL NAME>
  username: <AWESOME USER NAME>
  webhook_url: <SLACK WEBHOOK URL>
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

from the main directory. Here, no specific message is being given to print to Slack, so slack_messaging will choose a random quote. The random quotes are selected using the [Quotable API](http://api.quotable.io/).

However, what if you wanted to print something specific? Well, you can! Just run:

```
slack-messaging slack "MESSAGE 1"
```

You can even print multiple messages at once:

```
slack-messaging slack "MESSAGE 1" "MESSAGE 2" "MESSAGE 3" ... "MESSAGE N"
```

The output of slack_messaging will look something like this:

<img src="https://github.com/emmahsax/slack_messaging/blob/main/QuoteExample.png" width="500">

I hope you enjoy printing fun and specialized messages to Slack!

### Tests

To run the tests, run `bundle exec rspec` from the command line. GitHub Actions will also run the tests upon every commit to make sure they're up to date and that everything is working correctly. Locally, you can also run `bundle exec guard` to automatically run tests as you develop! There are currently only tests for the `notify_slack` and `random_message` classes. Feel free to help us add more!

## Contributing

To submit a feature request, bug ticket, etc, please submit an official [GitHub Issue](https://github.com/emmahsax/slack_messaging/issues/new).

To report any security vulnerabilities, please view this project's [Security Policy](https://github.com/emmahsax/slack_messaging/security/policy).

When interacting with this repository, please follow [Contributor Covenant's Code of Conduct](https://contributor-covenant.org).

## Releasing

To make a new release of this gem:

1. Merge the pull request via the big green button
2. Run `git tag vX.X.X` and `git push --tag`
3. Make a new release [here](https://github.com/emmahsax/slack_messaging/releases/new)
4. Run `gem build *.gemspec`
5. Run `gem push *.gem` to push the new gem to RubyGems
6. Run `rm *.gem` to clean up your local repository

To set up your local machine to push to RubyGems via the API, see the [RubyGems documentation](https://guides.rubygems.org/publishing/#publishing-to-rubygemsorg).
