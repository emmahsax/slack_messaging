# frozen_string_literal: true

module SlackMessaging
  class Setup
    class << self
      # rubocop:disable Style/ConditionalAssignment
      def execute
        if config_file_exists?
          answer = highline.ask_yes_no(
            "It looks like the #{default_config} file already exists. Do you wish to replace it? (y/n)",
            { required: true }
          )
        else
          answer = true
        end

        create_or_update_config_file(ask_config_questions) if answer
      end
      # rubocop:enable Style/ConditionalAssignment

      private def create_or_update_config_file(answers)
        contents = generate_config_file(answers)
        puts "Creating or updating your #{default_config} file..."
        File.open(default_config, 'w') { |file| file.puts contents }
        puts "\nDone!"
      end

      private def generate_config_file(answers)
        file_contents = ''.dup
        file_contents << "slack:\n"
        file_contents << "  channel: #{answers[:channel].tr('#', '').strip}\n"
        file_contents << "  username: #{answers[:username].strip}\n"
        file_contents << "  webhook_url: #{answers[:webhook_url].strip}\n"
        file_contents << "  icon_emoji: '#{answers[:icon_emoji].strip}'"
        file_contents
      end

      private def config_file_exists?
        File.exist?(default_config)
      end

      # rubocop:disable Metrics/MethodLength
      private def ask_config_questions
        answers = {}

        answers[:webhook_url] = ask_question(
          "What is your Slack webhook URL? If you don't have one yet, please navigate" \
          ' to https://api.slack.com/messaging/webhooks to create one, and then come back' \
          ' here and paste it in the Terminal.',
          required: true
        )

        answers[:channel] = ask_question(
          'What slack channel do you wish to post to? (default is "#general")'
        ) || 'general'

        answers[:username] = ask_question(
          "What slack username do you wish to post as? (default is \"Let's Get Quoty\")"
        ) || "Let's Get Quoty"

        answers[:icon_emoji] = ask_question(
          'What emoji would you like to post with (include the colons at the beginning and end' \
          ' of the emoji name)? (default is ":mailbox_with_mail:")'
        ) || ':mailbox_with_mail:'

        answers
      end
      # rubocop:enable Metrics/MethodLength

      private def ask_question(prompt, required: false)
        answer = highline.ask(prompt, { required: required })
        answer.empty? ? nil : answer
      end

      private def highline
        @highline ||= HighlineWrapper.new
      end

      private def default_config
        SlackMessaging::DefaultPaths.config
      end
    end
  end
end
