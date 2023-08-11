# Slack Messaging

This is a simple project designed to post messages to a given Slack or Discord channel as a bot.

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

## Setup

This project requires a config file that should look like this:

```yml
discord:
  avatar_url: <PUBLIC URL OF AN IMAGE>
  username: <AWESOME USER NAME>
  webhook_url: <DISCORD WEBHOOK URL>
slack:
  channel: <AWESOME CHANNEL NAME>
  username: <AWESOME USER NAME>
  webhook_url: <SLACK WEBHOOK URL>
  icon_emoji: ':<SOME EMOJI>:'
```

A config file can have both Discord and Slack settings, or just one or the other. To easily generate this file at `~/.slack_messaging.yml`, please run this command once for each setting type:

```bash
slack-messaging setup
```

To obtain a Slack webhook URL, follow [these instructions](https://slack.com/help/articles/115005265063-Incoming-webhooks-for-Slack). To obtain a Discord webhook URL, follow [these instructions](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks).

If you'd like to create the config file at a different directory, I recommend using the `setup` command, and then manually moving the file to your desired location:

```bash
slack-messaging setup
# Walk through the prompts to create the file
mv ~/.slack_messaging.yml /PATH/TO/FILE/config.yml
```

And then you can pass in that specific file location using the global `-c`/`--config` flag:

```bash
slack-messaging --config="/PATH/TO/FILE/config.yml" send
```

## Usage

To print a friendly message to Slack, run:

```bash
slack-messaging send
```

Here, no specific message is being given to print to Slack, so slack_messaging will choose a random quote. The random quotes are selected using the [Quotable API](http://api.quotable.io/).

However, what if you wanted to print something specific? Well, you can! Just run:

```bash
slack-messaging send 'MESSAGE 1'
```

You can even print multiple messages at once:

```bash
slack-messaging send 'MESSAGE 1' 'MESSAGE 2' 'MESSAGE 3' ... 'MESSAGE N'
```

> When using special characters in your custom messages, use single quotes instead of double quotes

If your config file contains both Slack and Discord settings, then running a basic `send` command (either passing in a message or not), will notify both Slack and Discord. To specify which service to send a message to, you can pass in a `-s`/`--service` flag:

```bash
slack-messaging send --service slack
# OR
slack-messaging send --service discord
```

To specify a service _and_ send a customized message, you can pass both at once:

```bash
slack-messaging send -s slack 'MESSAGE 1'
```

The output of a Slack message will look something like this:

<img src="https://github.com/emmahsax/slack_messaging/blob/main/message_slack.png" width="500">

The output of a Discord message will look something like this:

<img src="https://github.com/emmahsax/slack_messaging/blob/main/message_discord.png" width="500">

I hope you enjoy printing fun and specialized messages to Slack!

## Tests

To run the tests, run `bundle exec rspec` from the command-line. GitHub Actions will also run the tests upon every commit to make sure they're up to date and that everything is working correctly. Locally, you can also run `bundle exec guard` to automatically run tests as you develop!

---

### Contributing

To submit a feature request, bug ticket, etc, please submit an official [GitHub issue](https://github.com/emmahsax/slack_messaging/issues/new). To copy or make changes, please [fork this repository](https://github.com/emmahsax/slack_messaging/fork). When/if you'd like to contribute back to this upstream, please create a pull request on this repository.

Please follow included Issue Template(s) and Pull Request Template(s) when creating issues or pull requests.

### Security Policy

To report any security vulnerabilities, please view this repository's [Security Policy](https://github.com/emmahsax/slack_messaging/security/policy).

### Licensing

For information on licensing, please see [LICENSE.md](https://github.com/emmahsax/slack_messaging/blob/main/LICENSE.md).

### Code of Conduct

When interacting with this repository, please follow [Contributor Covenant's Code of Conduct](https://contributor-covenant.org).

### Releasing

To make a new release of this gem:

1. Merge the pull request via the big green button
2. Run `git tag vX.X.X` and `git push --tag`
3. Make a new release [here](https://github.com/emmahsax/slack_messaging/releases/new)
4. Run `gem build *.gemspec`
5. Run `gem push *.gem` to push the new gem to RubyGems
6. Run `rm *.gem` to clean up your local repository

To set up your local machine to push to RubyGems via the API, see the [RubyGems documentation](https://guides.rubygems.org/publishing/#publishing-to-rubygemsorg).

### Archival Notice

This repository has been archived and designated as read-only. From GitHub's documentation:

> This will make the emmahsax/slack_messaging repository, issues, pull requests, labels, milestones, projects, wiki, releases, commits, tags, branches, reactions and comments read-only and disable any future comments. The repository can still be forked.

To unarchive this repository at any time, please reach out to me at https://emmasax.com/contact-me/.
