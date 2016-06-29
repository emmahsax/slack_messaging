require 'slack-notifier'

module SlackMessaging
  class NotifySlack
    attr_accessor :text, :channel, :webhook_url, :username, :icon_url, :icon_emoji

    def initialize(text)
      self.text = text
      self.channel = SlackMessaging::Config.slack[:channel]
      self.webhook_url = SlackMessaging::Config.slack[:webhook_url]
      self.username = SlackMessaging::Config.slack[:username] || "MessageMe"
      self.icon_emoji = SlackMessaging::Config.slack[:icon_emoji] || ":mailbox_with_mail"
    end

    def perform
      options = {webhook_url: webhook_url,
                 channel: channel,
                 username: username,
                 icon_emoji: icon_emoji,
                 http_options: {open_timeout: 10}
                }
      Slack::Notifier.new(webhook_url, options).ping(text)
    end
  end
end
