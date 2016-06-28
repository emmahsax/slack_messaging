desc 'Prints a variety of messages to Slack'
command 'slack' do |c|
  c.action do |global_options, options, args|
    require_relative '../scripts/slack'
    SlackMessaging::Scripts::Slack.execute(args, options) # args are optional string to print
  end
end
