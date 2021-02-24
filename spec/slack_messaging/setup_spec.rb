require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::Setup do
  let(:response) { double(:response, readline: true, to_s: Faker::Lorem.sentence) }
  let(:highline_client) { double(:highline_cli, ask: response, ask_yes_no: true) }

  before do
    allow(HighLineCli).to receive(:new).and_return(highline_client)
  end
end
