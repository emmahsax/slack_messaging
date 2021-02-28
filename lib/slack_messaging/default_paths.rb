# frozen_string_literal: true

module SlackMessaging
  class DefaultPaths
    def self.config
      File.join(home, '.slack_messaging.yml')
    end

    def self.home
      ENV['HOME'] || '.'
    end
  end
end
