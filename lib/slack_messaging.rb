require 'yaml'
require 'hashie'
require 'httparty'
require 'highline'
require 'json'

Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), 'slack_messaging')) + '/**/*.rb'].each do |file|
  require_relative file
end

module SlackMessaging; end
