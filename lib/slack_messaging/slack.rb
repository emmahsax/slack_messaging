module SlackMessaging
  class Slack
    attr_accessor :options

    def self.execute(args, options = nil)
      if args.empty?
        message = SlackMessaging::RandomMessage.new
        print_message(message.text)
      else
        args.each do |message|
          print_message(message)
        end
      end
    end

    def self.print_message(message)
      SlackMessaging::NotifySlack.new(message).perform
    end
  end
end
