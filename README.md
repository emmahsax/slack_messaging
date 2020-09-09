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
  channel: "#[AWESOME CHANNEL NAME]"
  username: [AWESOME USER NAME]
  webhook_url: [WEBHOOK URL]
  icon_emoji: ":[SOME EMOJI]:"
```

The default is for the file to be named `~/.slack_messaging.yml`, but a different path can be passed in like this:

    $ slack-messaging --config="/PATH/TO/FILE/config.yml" slack

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

To run the tests, run `rspec` from the command line. Travis CI will also run the tests upon every commit to make sure they're up to date and that everything is working correctly. There are currently only tests for the `notify_slack` and `random_message` classes. Feel free to help us add more!

### RubyGems
To make a new version and push to RubyGems:

1. Update the CHANGELOG.markdown with the new version and changes made

3. Run `git add -A && git commit -m "Updating Changelog for [version number]"`

2. Update `lib/slack_messaging/version.rb` with the new version number

4. Run `git add -A && git commit -m "Version Bump" && git push`

5. Run `gem build slack_messaging.gemspec && gem push *.gem`

6. Run `rm *.gem`
