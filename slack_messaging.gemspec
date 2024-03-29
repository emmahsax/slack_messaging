# frozen_string_literal: true

require File.expand_path('lib/slack_messaging/version.rb', __dir__)

Gem::Specification.new do |gem|
  gem.authors               = ['Emma Sax']
  gem.description           = 'Sending personalized messages and quotes to a Slack channel of your ' \
                              'choice via the command-line.'
  gem.executables           = Dir['bin/*'].map { |f| File.basename(f) }

  gem.files = Dir['lib/slack_messaging/*.rb'] + Dir['lib/*.rb'] + Dir['bin/*']
  gem.files += Dir['[A-Z]*'] + Dir['test/**/*']
  gem.files.reject! { |fn| fn.include? '.gem' }

  gem.homepage              = 'https://github.com/emmahsax/slack_messaging'
  gem.license               = 'BSD-3-Clause'
  gem.metadata              = { 'rubygems_mfa_required' => 'true' }
  gem.name                  = 'slack_messaging'
  gem.require_paths         = ['lib']
  gem.required_ruby_version = '>= 2.4'
  gem.summary               = 'Personalized quotes and messages sent straight to Slack'
  gem.version               = SlackMessaging::VERSION

  gem.add_dependency 'gli', '~> 2.10'
  gem.add_dependency 'hashie', '>= 4.1', '<= 5'
  gem.add_dependency 'highline_wrapper', '~> 1.1'
  gem.add_dependency 'httparty', '~> 0.21'
  gem.add_dependency 'json', '~> 2.5'

  gem.add_development_dependency 'bundler', '~> 2.2'
  gem.add_development_dependency 'faker', '~> 3.0'
  gem.add_development_dependency 'guard-rspec', '~> 4.3'
  gem.add_development_dependency 'pry', '~> 0.13'
  gem.add_development_dependency 'rspec', '~> 3.9'
  gem.add_development_dependency 'rubocop', '~> 1.10'
end
