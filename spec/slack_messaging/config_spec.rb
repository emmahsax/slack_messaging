# frozen_string_literal: true

require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::Config do
  subject { SlackMessaging::Config }

  context 'config key methods' do
    it 'should return nil when not set' do
      expect(subject.doesnt_exist).to eql(nil)
      expect(subject.doesnt_exist?).to eql(false)
    end

    it 'should return the config value when set' do
      config_value = Faker::Lorem.word
      subject.new_value = config_value
      expect(subject.new_value).to eql(config_value)
    end
  end

  context 'after loading a config file' do
    let(:domain) { Faker::Internet.domain_name }
    let(:sentence) { Faker::Lorem.sentence }

    let(:config_file) do
      {
        domain: domain,
        slack: {
          channel: Faker::Lorem.word,
          icon_url: Faker::Internet.url,
          username: Faker::Name.name,
          webhook: Faker::Internet.url
        },
        discord: {
          avatar_url: Faker::Internet.url,
          username: Faker::Name.name,
          webhook: Faker::Internet.url
        }
      }
    end

    before do
      allow(YAML).to receive(:load_file).and_return(config_file)
      allow(File).to receive(:exist?).and_return(true)
      subject.load(Faker::Lorem.word)
    end

    it 'calling a method corresponding to a key in the file should return the value' do
      expect(subject.domain).to eql(domain)
      expect(subject.slack).to be_kind_of(Hash)
      expect(subject.discord).to be_kind_of(Hash)
      expect(subject.slack[:channel]).to be_kind_of(String)
      expect(subject.discord[:avatar_url]).to be_kind_of(String)
    end

    it 'overwriting values should work' do
      expect(subject.slack).to be_kind_of(Hash)
      subject.slack = sentence
      expect(subject.slack).to eql(sentence)
    end
  end
end
