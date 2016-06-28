# Slack Messaging

To print to Slack, this project requires a config file called `~/.slack_messaging.yml`. The config file should look like this:

```
slack:
  channel: "#[AWESOME CHANNEL NAME]"
  username: [AWESOME USER NAME]
  webhook_url: [WEBHOOK URL]
  icon_emoji: ":[SOME EMOJI]:"
```

To obtain the webhook url, go to [this link](https://api.slack.com/incoming-webhooks).

To run this command, run `bin/slack-messaging slack`. If you run this, the system will automatically choose a random message. However, you can specify a certain message to print like this: `bin/slack-messaging slack "MESSAGE"`. You can even specify multiple messages to print: `bin/slack-messaging slack "MESSAGE1" "MESSAGE2" "MESSAGE3"`.

