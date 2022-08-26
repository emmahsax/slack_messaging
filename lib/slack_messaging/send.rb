# frozen_string_literal: true

module SlackMessaging
  class Send
    class << self
      attr_accessor :options

      def execute(args, options)
        if args.empty?
          message = SlackMessaging::RandomMessage.acquire_random_quote
          distribute_notification(message, options[:service])
        else
          args.each do |arg_message|
            distribute_notification(arg_message, options[:service])
          end
        end
      end

      private def distribute_notification(message, service)
        if service
          print_message(message, service)
        else
          SlackMessaging::Config.full_config.each { |s, _| print_message(message, s) }
        end
      end

      private def print_message(message, service)
        case service
        when 'discord'
          SlackMessaging::NotifyDiscord.new(message).perform
        when 'slack'
          SlackMessaging::NotifySlack.new(message).perform
        end
      end
    end
  end
end
