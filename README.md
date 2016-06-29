# Slack Messaging [![Build Status](https://travis-ci.org/emmasax1/slack_messaging.svg?branch=master)](https://travis-ci.org/emmasax1/slack_messaging)

This is a simple project designed to post messages to a given Slack channel as a bot.

### Usage

First, run:

```
gem install bundler
bundle install
```

Then, the project should be ready to go! However, it won't necessarily know where to print to Slack. So, this project requires a config file called `~/.slack_messaging.yml`. The config file should look like this:

```
slack:
  channel: "#[AWESOME CHANNEL NAME]"
  username: [AWESOME USER NAME]
  webhook_url: [WEBHOOK URL]
  icon_emoji: ":[SOME EMOJI]:"
```

To obtain the webhook url, go to [this link](https://api.slack.com/incoming-webhooks).

Okay, now the project will _actually_ be ready to rock and roll.

To print a friendly message to Slack, run:

```
bin/slack-messaging slack
```

from the main directory. Here, no specific message is being given to print to Slack, so slack_messaging will choose a random quote, which are all defined in [`lib/slack_messaging/random_message.rb`](https://github.com/emmasax1/slack_messaging/blob/master/lib/slack_messaging/random_message.rb). Feel free to change the messages or add more to cater what you'd like slack_messaging to say.

However, what if you wanted to print something specific? Well, you can! Just run:

```
bin/slack-messaging slack "MESSAGE 1"
```

You can even print multiple messages at once:

```
bin/slack-messaging slack "MESSAGE 1" "MESSAGE 2" "MESSAGE 3" ... "MESSAGE N"
```

The output of slack_messaging will look something like this:

<img src="https://github.com/emmasax1/slack_messaging/blob/master/OutputFile.png" width="1000">

I hope you enjoy printing fun and specialized messages to Slack!

### Tests

To run the tests, run `rspec` from the command line. All tests should pass. There are currently only tests for the `notify_slack` and `random_message` classes. Feel free to help us add more!

To contribute:

1. Fork it (https://github.com/emmasax1/slack_messaging/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
