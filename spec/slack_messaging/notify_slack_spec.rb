require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::NotifySlack do
  let(:sentence) { Faker::Lorem.sentence }
  let(:channel) { Faker::Lorem.word }
  let(:username) { Faker::Name.name }
  let(:webhook) { Faker::Internet.url }
  let(:emoji) { Faker::Internet.url }

  let(:config_file) do
    {
      'slack': {
        'slack_option': true,
        'username': username,
        'icon_emoji': emoji,
        'channel': channel,
        'webhook_url': webhook
      }
    }
  end

  before :each do
    allow(YAML).to receive(:load_file).and_return(config_file)
    allow(File).to receive(:exist?).and_return(true)
    SlackMessaging::Config.load(Faker::Lorem.word)
  end

  subject { SlackMessaging::NotifySlack }

  it 'should call HTTParty' do
    expect(HTTParty).to receive(:post)
    message = subject.new(sentence)
    message.perform
  end

    it 'should define certain values' do
    message = subject.new(sentence)
    expect(message.text).to eq(sentence)
    expect(message.channel).to eq(channel)
    expect(message.username).to eq(username)
    expect(message.webhook_url).to eq(webhook)
    expect(message.icon_emoji).to eq(emoji)
  end
end
