# frozen_string_literal: true

module SlackMessaging
  class DefaultPaths
    class << self
      def config
        File.join(home, '.slack_messaging.yml')
      end

      private def home
        ENV['HOME'] || '.'
      end
    end
  end
end
