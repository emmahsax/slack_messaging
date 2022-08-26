# frozen_string_literal: true

require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::Setup do
  let(:highline_wrapper) { double(:highline_wrapper, ask: Faker::Lorem.word, ask_yes_no: true, ask_multiple_choice: {value: 'Discord'}) }

  let(:answers) do
    {
      avatar_url: Faker::Lorem.word,
      channel: Faker::Lorem.word,
      username: Faker::Lorem.word,
      webhook_url: Faker::Internet.url,
      icon_emoji: ":#{Faker::Lorem.word}:"
    }
  end

  before do
    allow(HighlineWrapper).to receive(:new).and_return(highline_wrapper)
    allow(subject).to receive(:puts)
  end

  after do
    SlackMessaging::Setup.instance_variable_set('@highline', nil)
  end

  subject { SlackMessaging::Setup }

  describe '#self.execute' do
    it 'should ask a question if the config file exists' do
      allow(subject).to receive(:config_file_exists?).and_return(true)
      allow(File).to receive(:exists?).and_return(true)
      expect(highline_wrapper).to receive(:ask_yes_no).and_return(true)
      allow(subject).to receive(:create_or_update_config_file).and_return(true)
      allow(subject).to receive(:ask_slack_config_questions).and_return(true)
      subject.execute
    end

    it 'should ask the user which type of config to updatee' do
      allow(subject).to receive(:config_file_exists?).and_return(true)
      allow(File).to receive(:exists?).and_return(true)
      expect(highline_wrapper).to receive(:ask_multiple_choice).and_return(value: 'Discord')
      subject.execute
    end

    it 'should call to generate the discord config file if discord is selected' do
      allow(subject).to receive(:config_file_exists?).and_return(true)
      allow(File).to receive(:exists?).and_return(true)
      expect(highline_wrapper).to receive(:ask_multiple_choice).and_return(value: 'Discord')
      expect(subject).to receive(:generate_discord_config_file)
      subject.execute
    end

    it 'should call to generate the slack config file if slack is selected' do
      allow(subject).to receive(:config_file_exists?).and_return(true)
      allow(File).to receive(:exists?).and_return(true)
      expect(highline_wrapper).to receive(:ask_multiple_choice).and_return(value: 'Slack')
      expect(subject).to receive(:generate_slack_config_file)
      subject.execute
    end

    it 'should call to create or update the config file' do
      allow(File).to receive(:exists?).and_return(true)
      allow(highline_wrapper).to receive(:ask_yes_no).and_return(true)
      allow(highline_wrapper).to receive(:ask_multiple_choice).and_return(value: 'Slack')
      allow(subject).to receive(:generate_slack_config_file).and_return(Faker::Lorem.sentence)
      expect(subject).to receive(:create_or_update_config_file).and_return(true)
      expect(subject).to receive(:ask_slack_config_questions).and_return(true)
      subject.execute
    end

    it 'should skip if the user opts not to continue' do
      allow(subject).to receive(:config_file_exists?).and_return(true)
      allow(File).to receive(:exists?).and_return(true)
      allow(highline_wrapper).to receive(:ask_yes_no).and_return(false)
      expect(subject).not_to receive(:create_or_update_config_file)
      expect(subject).not_to receive(:ask_slack_config_questions)
      expect { subject.execute }.to raise_error(SystemExit)
    end
  end

  describe '#self.create_or_update_config_file' do
    it 'should open the file for writing' do
      expect(File).to receive(:open).and_return(nil)
      subject.send(:create_or_update_config_file, Faker::Lorem.sentence)
    end
  end

  describe '#self.generate_discord_config_file' do
    it 'calls the compare configs method' do
      expect(subject).to receive(:compare_configs)
      subject.send(:generate_discord_config_file, answers)
    end

    it 'returns a string' do
      expect(subject.send(:generate_discord_config_file, answers)).to be_a(String)
    end
  end

  describe '#self.generate_slack_config_file' do
    it 'calls the compare configs method' do
      expect(subject).to receive(:compare_configs)
      subject.send(:generate_slack_config_file, answers)
    end

    it 'returns a string' do
      expect(subject.send(:generate_slack_config_file, answers)).to be_a(String)
    end
  end

  describe '#self.compare_configs' do
    context 'when the regex is present' do
      it 'should replace the old contents with the new contents' do
        new_contents = Faker::Lorem.sentence
        replacement = Faker::Lorem.word
        old_contents = "#{replacement}#{Faker::Lorem.sentence}"
        regex = /(#{replacement})/
        allow(subject).to receive(:config_file_exists?).and_return(true)
        allow(File).to receive(:read).and_return(old_contents)
        expect(subject.send(:compare_configs, regex, new_contents)).to eq(new_contents << old_contents.gsub(regex, ''))
      end
    end

    context 'when the regex is not present' do
      it 'should append the new contents onto the old' do
        new_contents = Faker::Lorem.sentence
        old_contents = Faker::Lorem.sentence
        regex = /(discord:\n\s+avatar_url: \S+\n\s+username: [ \S]+\n\s+webhook_url: \S+\n)/
        allow(subject).to receive(:config_file_exists?).and_return(true)
        allow(File).to receive(:read).and_return(old_contents)
        expect(subject.send(:compare_configs, regex, new_contents)).to eq(old_contents << new_contents)
      end
    end

    context 'when the file does not exist at all' do
      it 'should just return the file contents' do
        contents = Faker::Lorem.sentence
        regex = /(discord:\n\s+avatar_url: \S+\n\s+username: [ \S]+\n\s+webhook_url: \S+\n)/
        allow(subject).to receive(:config_file_exists?).and_return(false)
        expect(subject.send(:compare_configs, regex, contents)).to eq(contents)
      end
    end
  end

  describe '#self.config_file_exists?' do
    it 'should return true if the file exists' do
      allow(File).to receive(:exist?).and_return(true)
      expect(subject.send(:config_file_exists?)).to eq(true)
    end

    it 'should return false if the file does not exist' do
      allow(File).to receive(:exist?).and_return(false)
      expect(subject.send(:config_file_exists?)).to eq(false)
    end
  end

  describe '#self.ask_question' do
    it 'should use highline to ask a question' do
      expect(highline_wrapper).to receive(:ask).and_return('')
      subject.send(:ask_question, Faker::Lorem.sentence, nil)
    end

    it 'should return nil if the highline client gets an empty string' do
      allow(highline_wrapper).to receive(:ask).and_return(nil)
      expect(subject.send(:ask_question, Faker::Lorem.sentence, nil)).to be_nil
    end

    it 'should return the answer if it is given' do
      answer = Faker::Lorem.sentence
      allow(highline_wrapper).to receive(:ask).and_return(answer)
      expect(subject.send(:ask_question, Faker::Lorem.sentence, :default)).to be(answer)
    end
  end

  describe '#self.ask_slack_config_questions' do
    it 'should call to ask at least four questions' do
      expect(subject).to receive(:ask_question).at_least(4).times.and_return(Faker::Lorem.word)
      subject.send(:ask_slack_config_questions)
    end

    it 'should return the defaults if nothing is given' do
      slack_url = Faker::Internet.url
      defaults = {
        channel: 'general',
        username: "Slack Messaging",
        webhook_url: slack_url,
        icon_emoji: ':robot_face:'
      }
      allow(subject).to receive(:ask_question).with(
        "What is your Slack webhook URL? If you don't have one yet, please navigate to https://api.slack.com/messaging/webhooks to create one, and then come back here and paste it in the Terminal.",
        nil,
        required: true
      ).and_return(slack_url)
      allow(subject).to receive(:ask_question).with(
        'What Slack channel do you wish to post to? (default is "#general")',
        '#general'
      ).and_return('general')
      allow(subject).to receive(:ask_question).with(
        "What Slack username do you wish to post as? (default is \"Slack Messaging\")",
        "Slack Messaging"
      ).and_return("Slack Messaging")
      allow(subject).to receive(:ask_question).with(
        'What emoji would you like to post with (include the colons at the beginning and end of the emoji name)? (default is ":robot_face:")',
        ':robot_face:'
      ).and_return(':robot_face:')
      expect(subject.send(:ask_slack_config_questions)).to eq(defaults)
    end
  end

  describe '#self.ask_discord_config_questions' do
    it 'should call to ask at least three questions' do
      expect(subject).to receive(:ask_question).at_least(3).times.and_return(Faker::Lorem.word)
      subject.send(:ask_discord_config_questions)
    end

    it 'should return the defaults if nothing is given' do
      discord_url = Faker::Internet.url
      defaults = {
        username: "Slack Messaging",
        webhook_url: discord_url,
        avatar_url: 'https://i.imgur.com/9ZTbiSF.jpg'
      }
      allow(subject).to receive(:ask_question).with(
        "What is your Discord webhook URL? If you don't have one yet, please navigate to https://discord.com/channels/@me to create one for your server, and then come back here and paste it in the Terminal.",
        nil,
        required: true
      ).and_return(discord_url)
      allow(subject).to receive(:ask_question).with(
        'What Discord username do you wish to post as? (default is "Slack Messaging")',
        "Slack Messaging"
      ).and_return("Slack Messaging")
      allow(subject).to receive(:ask_question).with(
        'What avatar URL would you like to post with? (default is "https://i.imgur.com/9ZTbiSF.jpg")',
        'https://i.imgur.com/9ZTbiSF.jpg'
      ).and_return('https://i.imgur.com/9ZTbiSF.jpg')
      expect(subject.send(:ask_discord_config_questions)).to eq(defaults)
    end
  end
end
