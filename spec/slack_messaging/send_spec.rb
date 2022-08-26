# frozen_string_literal: true

require 'spec_helper'
require 'slack_messaging'

describe SlackMessaging::Send do
  let(:config_file) do
    {
      slack: {},
      discord: {}
    }
  end

  before :each do
    allow(YAML).to receive(:load_file).and_return(config_file)
    allow(File).to receive(:exist?).and_return(true)
    SlackMessaging::Config.load(Faker::Lorem.word)
  end

  subject { SlackMessaging::Send }

  describe '#execute' do
    context 'with no message passed' do
      it 'should generate a random message' do
        expect(SlackMessaging::RandomMessage).to receive(:acquire_random_quote)
        expect(subject).to receive(:distribute_notification).once
        subject.execute([], {})
      end
    end

    context 'with a message passed' do
      it 'should call to distribute a notification for each message passed' do
        expect(subject).to receive(:distribute_notification).exactly(2).times
        subject.execute(['message one', 'message two'], {})
      end
    end

    describe '#distribute_notification' do
      context 'with a service passed in' do
        it 'should print the message if a service is passed' do
          expect(subject).to receive(:print_message)
          subject.send(:distribute_notification, 'message', 'service')
        end
      end

      context 'with no service passed in' do
        it 'should print the message once for each service' do
          expect(subject).to receive(:print_message).at_least(2).times
          subject.send(:distribute_notification, 'message', nil)
        end
      end
    end
  end
end
