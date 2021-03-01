# frozen_string_literal: true

module SlackMessaging
  class Send
    attr_accessor :options

    def self.execute(args, _options = nil)
      if args.empty?
        message = SlackMessaging::RandomMessage.acquire_random_quote
        print_message(message)
      else
        args.each do |arg_message|
          print_message(arg_message)
        end
      end
    end

    def self.print_message(message)
      SlackMessaging::NotifySlack.new(message).perform
    end
  end
end
