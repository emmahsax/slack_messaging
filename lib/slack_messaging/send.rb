# frozen_string_literal: true

module SlackMessaging
  class Send
    class << self
      attr_accessor :options

      def execute(args, _options = nil)
        if args.empty?
          message = SlackMessaging::RandomMessage.acquire_random_quote
          print_message(message)
        else
          args.each do |arg_message|
            print_message(arg_message)
          end
        end
      end

      private def print_message(message)
        SlackMessaging::NotifySlack.new(message).perform
      end
    end
  end
end
