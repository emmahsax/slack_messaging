# frozen_string_literal: true

require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::NotifyDiscord do
  let(:sentence) { Faker::Lorem.sentence }
  let(:username) { Faker::Name.name }
  let(:webhook) { Faker::Internet.url }
  let(:avatar) { Faker::Internet.url }

  let(:config_file) do
    {
      discord: {
        avatar_url: avatar,
        username: username,
        webhook_url: webhook
      }
    }
  end

  before :each do
    allow(YAML).to receive(:load_file).and_return(config_file)
    allow(File).to receive(:exist?).and_return(true)
    SlackMessaging::Config.load(Faker::Lorem.word)
  end

  subject { SlackMessaging::NotifyDiscord.new(sentence) }

  it 'should call cURL via a backtick' do
    expect(subject).to receive(:`)
    subject.perform
  end

  it 'should define certain values' do
    expect(subject.avatar_url).to eq(avatar)
    expect(subject.text).to eq(sentence)
    expect(subject.username).to eq(username)
    expect(subject.webhook_url).to eq(webhook)
  end
end
