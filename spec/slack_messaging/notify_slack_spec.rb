require "slack_messaging"

module SlackMessaging
  describe NotifySlack do
    before :each do
      config_file = {"slack" => {"channel" => "#random-test-channel",
                                 "username" => "Random User",
                                 "webhook_url" => "https://hooks.slack.com/services/totallyrandom/fakewebhookurl",
                                 "icon_emoji" => ":wine_glass:"}
                    }
      allow(YAML).to receive(:load_file).and_return(config_file)
      allow(File).to receive(:exist?).and_return(true)
      SlackMessaging::Config.load("dummy/path")
    end

    it 'should ping Slack Notifier' do
      notifier = double('notifier', ping: true)
      allow(Slack::Notifier).to receive(:new).and_return(notifier)
      expect(notifier).to receive(:ping).and_return(true)
      message = NotifySlack.new("Test message")
      message.perform
    end

     it 'should define certain values' do
      message = NotifySlack.new("Test message")
      expect(message.text).to eq("Test message")
      expect(message.channel).to eq("#random-test-channel")
      expect(message.username).to eq("Random User")
      expect(message.webhook_url).to eq("https://hooks.slack.com/services/totallyrandom/fakewebhookurl")
      expect(message.icon_emoji).to eq(":wine_glass:")
    end
    
  end
end
