# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
module SlackMessaging
  class Setup
    class << self
      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Style/ConditionalAssignment
      def execute
        if config_file_exists?
          answer = highline.ask_yes_no(
            "It looks like the #{default_config} file already exists. Do you wish to edit it? (y/n)",
            { required: true }
          )
        else
          answer = true
        end

        exit unless answer

        type = highline.ask_multiple_choice(
          'Which type of config do you wish to create/update?',
          %w[Discord Slack],
          required: true
        )[:value]

        case type
        when 'Discord'
          file_contents = generate_discord_config_file(ask_discord_config_questions)
        when 'Slack'
          file_contents = generate_slack_config_file(ask_slack_config_questions)
        end

        create_or_update_config_file(file_contents)
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Style/ConditionalAssignment

      private def create_or_update_config_file(contents)
        puts "Creating or updating your #{default_config} file..."
        File.open(default_config, 'w') { |file| file.puts contents }
        puts 'Done!'
      end

      private def generate_discord_config_file(answers)
        file_contents = ''.dup
        file_contents << "discord:\n"
        file_contents << "  avatar_url: #{answers[:avatar_url].strip}\n"
        file_contents << "  username: #{answers[:username].strip}\n"
        file_contents << "  webhook_url: #{answers[:webhook_url].strip}\n"
        contents_regex = /(discord:\n\s+avatar_url: \S+\n\s+username: [ \S]+\n\s+webhook_url: \S+\n)/
        compare_configs(contents_regex, file_contents)
      end

      private def generate_slack_config_file(answers)
        file_contents = ''.dup
        file_contents << "slack:\n"
        file_contents << "  channel: #{answers[:channel].tr('#', '').strip}\n"
        file_contents << "  icon_emoji: '#{answers[:icon_emoji].strip}'\n"
        file_contents << "  username: #{answers[:username].strip}\n"
        file_contents << "  webhook_url: #{answers[:webhook_url].strip}\n"
        contents_regex = /(slack:\n\s+channel: \S+\n\s+icon_emoji: \S+\n\s+username: [ \S]+\n\s+webhook_url: \S+\n)/
        compare_configs(contents_regex, file_contents)
      end

      private def compare_configs(contents_regex, file_contents)
        if config_file_exists? && contents_regex.match(File.read(default_config))
          File.read(default_config).gsub(contents_regex, file_contents)
        elsif config_file_exists?
          File.read(default_config) << file_contents
        else
          file_contents
        end
      end

      private def config_file_exists?
        File.exist?(default_config)
      end

      # rubocop:disable Metrics/MethodLength
      private def ask_discord_config_questions
        answers = {}

        answers[:webhook_url] = ask_question(
          "What is your Discord webhook URL? If you don't have one yet, please navigate " \
          'to https://discord.com/channels/@me to create one for your server, and then come back ' \
          'here and paste it in the Terminal.',
          nil,
          required: true
        )

        answers[:username] = ask_question(
          'What Discord username do you wish to post as? (default is "Slack Messaging")',
          'Slack Messaging'
        )

        answers[:avatar_url] = ask_question(
          'What avatar URL would you like to post with? (default is "https://i.imgur.com/9ZTbiSF.jpg")',
          'https://i.imgur.com/9ZTbiSF.jpg'
        )

        answers
      end

      private def ask_slack_config_questions
        answers = {}

        answers[:webhook_url] = ask_question(
          "What is your Slack webhook URL? If you don't have one yet, please navigate " \
          'to https://api.slack.com/messaging/webhooks to create one, and then come back ' \
          'here and paste it in the Terminal.',
          nil,
          required: true
        )

        answers[:channel] = ask_question(
          'What Slack channel do you wish to post to? (default is "#general")',
          '#general'
        )

        answers[:username] = ask_question(
          'What Slack username do you wish to post as? (default is "Slack Messaging")',
          'Slack Messaging'
        )

        answers[:icon_emoji] = ask_question(
          'What emoji would you like to post with (include the colons at the beginning and end ' \
          'of the emoji name)? (default is ":robot_face:")',
          ':robot_face:'
        )

        answers
      end
      # rubocop:enable Metrics/MethodLength

      private def ask_question(prompt, default, required: false)
        highline.ask(prompt, { default: default, required: required })
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
# rubocop:enable Metrics/ClassLength
