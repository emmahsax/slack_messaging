require 'spec_helper'
require 'slack_messaging'

RSpec.describe SlackMessaging::RandomMessage do
  it "should get a string message" do
    message = SlackMessaging::RandomMessage.new
    expect(message.text).to be_instance_of(String)
  end

  it "should get a message greater than 25 characters" do
    message = SlackMessaging::RandomMessage.new
    expect(message.text.length).to be >= 50
  end

  it "should get a message that includes a new line" do
    message = SlackMessaging::RandomMessage.new
    expect(message.text.include?("\n")).to eq(true)
  end

  it "should get a message that includes a '--'" do
    message = SlackMessaging::RandomMessage.new
    expect(message.text.include?("--")).to eq(true)
  end
end
