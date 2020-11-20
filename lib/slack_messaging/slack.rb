module SlackMessaging
  class Slack
    attr_accessor :options

    def self.execute(args, options = nil)
      if args.empty?
        message = SlackMessaging::RandomMessage.acquire_random_quote
        print_message(message)
      else
        args.each do |message|
          print_message(message)
        end
      end
    end

    private

    def self.print_message(message)
      SlackMessaging::NotifySlack.new(message).perform
    end
  end
end
