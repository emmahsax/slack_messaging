require 'highline/import'
require_relative "../notify_slack"

module SlackMessaging
  module Scripts
    class Slack
      class << self
        attr_accessor :options
      end

      def self.execute(args, options=nil)
        if args.empty?
          message_number = rand(8)
          print_message(message_number)
        else
          args.each do |message|
            print_given_message(message)
          end
        end
      end

      def self.print_given_message(message)
        slack_job = NotifySlack.new(message)
        # slack_job.perform
      end

      def self.print_message(message_number)
        message = ""

        case message_number
        when 0
          message = "A true friend is someone who thinks that you are a good egg even though he knows that you are slightly cracked.\n  --Bernard Meltzer"
        when 1
          message = "If you can't make it good, at least make it look good.\n  --Bill Gates"
        when 2
          message = "I'm convinced of this: Good done anywhere is good done everywhere.\n  --Maya Angelou"
        when 3
          message = "The real trouble with reality is that there's no background music.\n --Anonymous"
        when 4
          message = "Whatever you are, be a good one.\n  --Abraham Lincoln"
        when 5
          message = "At this point power failed high fantasy\n"
          message << "  but, like a wheel in perfect balance turning,\n"
          message << "  I felt my will and my desire impelled\n"
          message << "\nby the Love that moves the sun and the other stars.\n  --Dante Alighieri"
        when 6
          message = "Good, better, best. Never let it rest. 'Til your good is better and your better is best.\n  --St. Jerome"
        when 7
          message = "Despite everything, I believe that people are really good at heart\n  --Anne Frank"
        # when 8
        #   message = ""
        # when 9
        #   message = ""
        # when 10
        #   message = ""
        # when 11
        #   message = ""
        # when 12
        #   message = ""
        # when 13
        #   message = ""
        # when 14
        #   message = ""
        end

        puts message

        slack_job = NotifySlack.new(message)
        # slack_job.perform
      end
    end
  end
end
