# frozen_string_literal: true

module SlackMessaging
  class NotifySlack
    attr_accessor :channel, :icon_emoji, :text, :username, :webhook_url

    def initialize(text)
      self.channel = SlackMessaging::Config.slack[:channel] || 'general'
      self.icon_emoji = SlackMessaging::Config.slack[:icon_emoji] || ':robot_face'
      self.text = text
      self.username = SlackMessaging::Config.slack[:username] || 'Slack Messaging'
      self.webhook_url = SlackMessaging::Config.slack[:webhook_url]
    end

    def perform
      options = {
        channel: channel,
        icon_emoji: icon_emoji,
        text: text,
        username: username
      }

      HTTParty.post(webhook_url, body: options.to_json)
    end
  end
end
