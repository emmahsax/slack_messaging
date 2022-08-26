# frozen_string_literal: true

module SlackMessaging
  class NotifyDiscord
    attr_accessor :avatar_url, :text, :username, :webhook_url

    def initialize(text)
      self.avatar_url = SlackMessaging::Config.discord[:avatar_url] || 'https://i.imgur.com/9ZTbiSF.jpg'
      self.text = text
      self.username = SlackMessaging::Config.discord[:username] || 'Slack Messaging'
      self.webhook_url = SlackMessaging::Config.discord[:webhook_url]
    end

    def perform
      options = {
        avatar_url: avatar_url,
        content: text,
        username: username
      }

      `curl -s -H "Content-Type: application/json" -d '#{options.to_json.gsub("'", "'\\\\''")}' '#{webhook_url}'`
    end
  end
end
