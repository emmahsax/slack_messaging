require 'spec_helper'
require 'slack_messaging'

module SlackMessaging
  describe RandomMessage do

    it "should get a string message" do
      message = RandomMessage.new
      expect(message.get_text).to be_instance_of(String)
    end

    it "should get a message greater than 25 characters" do
      message = RandomMessage.new
      expect(message.get_text.length).to be >= 50
    end

    it "should get a message that includes a new line" do
      message = RandomMessage.new
      expect(message.get_text.include?("\n")).to eq(true)
    end

    it "should get a message that includes a '--'" do
      message = RandomMessage.new
      expect(message.get_text.include?("--")).to eq(true)
    end
  end
end
