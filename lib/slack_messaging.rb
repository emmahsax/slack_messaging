# frozen_string_literal: true

require 'yaml'
require 'hashie'
require 'httparty'
require 'highline_wrapper'
require 'json'

files = "#{File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), 'slack_messaging'))}/**/*.rb"

Dir[files].sort.each do |file|
  require_relative file
end

module SlackMessaging; end
