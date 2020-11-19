require 'spec_helper'
require 'slack_messaging'

RSpec.describe SlackMessaging::Config do
  context "config key methods" do
    it "should return nil when not set" do
      expect(SlackMessaging::Config.doesnt_exist).to eql(nil)
      expect(SlackMessaging::Config.doesnt_exist?).to eql(false)
    end

    it "should return the config value when set" do
      config_value = Faker::Lorem.word
      SlackMessaging::Config.new_value = config_value
      expect(SlackMessaging::Config.new_value).to eql(config_value)
    end
  end

  context "after loading a config file" do
    let(:domain) { Faker::Internet.domain_name }
    let(:sentence) { Faker::Lorem.sentence }

    let(:config_file) do
      {
        "domain": domain,
        "slack": {
          "slack_option": true,
          "username": Faker::Name.name,
          "icon_url": Faker::Internet.url,
          "channel": Faker::Lorem.word,
          "webhook": Faker::Internet.url
        }
      }
    end

    before do
      allow(YAML).to receive(:load_file).and_return(config_file)
      allow(File).to receive(:exist?).and_return(true)
      SlackMessaging::Config.load(Faker::Lorem.word)
    end

    it "calling a method corresponding to a key in the file should return the value" do
      expect(SlackMessaging::Config.domain).to eql(domain)
      expect(SlackMessaging::Config.slack).to be_kind_of(Hash)
      expect(SlackMessaging::Config.slack[:slack_option]).to eql(true)
    end

    it "overwriting values should work" do
      expect(SlackMessaging::Config.slack).to be_kind_of(Hash)
      SlackMessaging::Config.slack = sentence
      expect(SlackMessaging::Config.slack).to eql(sentence)
    end
  end
end
