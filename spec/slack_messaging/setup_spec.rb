# frozen_string_literal: true

require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::Setup do
  let(:response) { double(:response, readline: true, to_s: Faker::Lorem.sentence) }
  let(:highline_cli) { double(:highline_cli, ask: response, ask_yes_no: true) }
  let(:answers) do
    {
      channel: Faker::Lorem.word,
      username: Faker::Lorem.word,
      webhook_url: Faker::Internet.url,
      icon_emoji: ":#{Faker::Lorem.word}:"
    }
  end

  before do
    allow(SlackMessaging::HighlineCli).to receive(:new).and_return(highline_cli)
    allow(subject).to receive(:puts)
  end

  after do
    SlackMessaging::Setup.instance_variable_set('@highline', nil)
  end

  subject { SlackMessaging::Setup }

  describe '#self.execute' do
    it 'should ask a question if the config file exists' do
      # allow(subject).to receive(:config_file_exists?).and_return(true)
      allow(File).to receive(:exists?).and_return(true)
      expect(highline_cli).to receive(:ask_yes_no).and_return(true)
      allow(subject).to receive(:create_or_update_config_file).and_return(true)
      allow(subject).to receive(:ask_config_questions).and_return(true)
      subject.execute
    end

    it 'should call to create or update the config file' do
      allow(File).to receive(:exists?).and_return(true)
      allow(highline_cli).to receive(:ask_yes_no).and_return(true)
      expect(subject).to receive(:create_or_update_config_file).and_return(true)
      expect(subject).to receive(:ask_config_questions).and_return(true)
      subject.execute
    end

    it 'should skip if the user opts not to continue' do
      allow(subject).to receive(:config_file_exists?).and_return(true)
      allow(File).to receive(:exists?).and_return(true)
      allow(highline_cli).to receive(:ask_yes_no).and_return(false)
      expect(subject).not_to receive(:create_or_update_config_file)
      expect(subject).not_to receive(:ask_config_questions)
      subject.execute
    end
  end

  describe '#self.create_or_update_config_file' do
    it 'should generate the file based on the answers to the questions' do
      expect(subject).to receive(:generate_config_file)
      allow(File).to receive(:open).and_return(nil)
      subject.send(:create_or_update_config_file, answers)
    end

    it 'should open the file for writing' do
      allow(subject).to receive(:generate_config_file)
      expect(File).to receive(:open).and_return(nil)
      subject.send(:create_or_update_config_file, answers)
    end
  end

  describe '#self.generate_config_file' do
    it 'returns a string' do
      expect(subject.send(:generate_config_file, answers)).to be_a(String)
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
      expect(highline_cli).to receive(:ask).and_return('')
      subject.send(:ask_question, Faker::Lorem.sentence)
    end

    it 'should return nil if the highline client gets an empty string' do
      allow(highline_cli).to receive(:ask).and_return('')
      expect(subject.send(:ask_question, Faker::Lorem.sentence)).to be_nil
    end

    it 'should return the answer if it is given' do
      answer = Faker::Lorem.sentence
      allow(highline_cli).to receive(:ask).and_return(answer)
      expect(subject.send(:ask_question, Faker::Lorem.sentence)).to be(answer)
    end
  end

  describe '#self.ask_config_questions' do
    it 'should call to ask at least four questions' do
      expect(subject).to receive(:ask_question).at_least(4).times.and_return(Faker::Lorem.word)
      subject.send(:ask_config_questions)
    end

    it 'should exit if the slack URL is not given' do
      allow(subject).to receive(:ask_question).and_return(nil)
      expect { subject.send(:ask_config_questions) }.to raise_error(SystemExit)
    end

    it 'should return the defaults if nothing is given' do
      slack_url = Faker::Internet.url
      defaults = {
        channel: 'general',
        username: "Let's Get Quoty",
        webhook_url: slack_url,
        icon_emoji: ':mailbox_with_mail:'
      }
      allow(subject).to receive(:ask_question).with("What is your Slack webhook URL? If you don't have one yet, please navigate to https://api.slack.com/messaging/webhooks to create one, and then come back here and paste it in the Terminal."
      ).and_return(slack_url)
      allow(subject).to receive(:ask_question).with(
        "\nWhat slack channel do you wish to post to? (default is \"#general\")"
      ).and_return(nil)
      allow(subject).to receive(:ask_question).with(
        "\nWhat slack username do you wish to post as? (default is \"Let's Get Quoty\")"
      ).and_return(nil)
      allow(subject).to receive(:ask_question).with(
        "\nWhat emoji would you like to post with (include the colons at the beginning and end of the emoji name)? (default is \":mailbox_with_mail:\")"
      ).and_return(nil)
      expect(subject.send(:ask_config_questions)).to eq(defaults)
    end
  end
end
