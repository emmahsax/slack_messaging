require 'slack-notifier'

module SlackMessaging
  class NotifySlack
    attr_accessor :text, :channel, :username, :icon_url, :icon_emoji

    CHANNEL = SlackMessaging::Config.slack[:channel]
    USERNAME = SlackMessaging::Config.slack[:username] || "MessageMe"
    WEBHOOK_URL = SlackMessaging::Config.slack[:webhook_url]
    ICON_EMOJI = SlackMessaging::Config.slack[:icon_emoji] || ":mailbox_with_mail:"

    def initialize(text)
      self.text = text
      self.channel = CHANNEL
      self.username = USERNAME
      self.icon_emoji = ICON_EMOJI
    end

    def perform
      options = {webhook_url: WEBHOOK_URL,
                 channel: CHANNEL,
                 username: USERNAME,
                 icon_emoji: ICON_EMOJI,
                 http_options: {open_timeout: 10}
                }
      Slack::Notifier.new(WEBHOOK_URL, options).ping(text)
    end
  end
end
