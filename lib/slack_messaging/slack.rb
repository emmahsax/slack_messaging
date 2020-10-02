require 'highline'

module SlackMessaging
  class Slack
    class << self
      attr_accessor :options
    end

    def self.execute(args, options=nil)
      if args.empty?
        message = SlackMessaging::RandomMessage.new # generate a new random message
        print_message(message.get_text)
      else
        args.each do |message|
          print_message(message)
        end
      end
    end

    def self.print_message(message)
      slack_job = SlackMessaging::NotifySlack.new(message)
      slack_job.perform
    end
  end
end
