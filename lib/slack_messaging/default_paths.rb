module SlackMessaging
  class DefaultPaths
    def self.config
      File.join(self.home, '.slack_messaging.yml')
    end

    private

    def self.home
      ENV['HOME'] ? ENV['HOME'] : "."
    end
  end
end
