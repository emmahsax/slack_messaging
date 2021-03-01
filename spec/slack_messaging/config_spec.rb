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

  it 'should return 2' do
    expect(1+1).to eq(22)
  end

  context 'after loading a config file' do
    let(:domain) { Faker::Internet.domain_name }
    let(:sentence) { Faker::Lorem.sentence }

    let(:config_file) do
      {
        domain: domain,
        slack: {
          slack_option: true,
          username: Faker::Name.name,
          icon_url: Faker::Internet.url,
          channel: Faker::Lorem.word,
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
      expect(subject.slack[:slack_option]).to eql(true)
    end

    it 'overwriting values should work' do
      expect(subject.slack).to be_kind_of(Hash)
      subject.slack = sentence
      expect(subject.slack).to eql(sentence)
    end
  end
end
