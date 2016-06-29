require 'highline/import'
require_relative "../notify_slack"
require_relative "../random_message"

module SlackMessaging
  module Scripts
    class Slack
      class << self
        attr_accessor :options
      end

      def self.execute(args, options=nil)
        if args.empty?
          message = RandomMessage.new # generate a new random message
          print_message(message.get_text)
        else
          args.each do |message|
            print_message(message)
          end
        end
      end

      def self.print_message(message)
        slack_job = NotifySlack.new(message)
        slack_job.perform
      end
    end
  end
end
