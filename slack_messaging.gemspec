# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_messaging/version'

Gem::Specification.new do |gem|
  gem.name          = "slack_messaging"
  gem.version       = SlackMessaging::VERSION
  gem.authors       = ["Emma Sax"]
  gem.email         = ["emma.sax4@gmail.com"]
  gem.summary       = %q{Sending Personalized Slack Messages}
  gem.description   = %q{Sending Personalized Slack Messages}
  gem.homepage      = "https://github.com/emmasax4/slack_messaging"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'hashie', '~> 4.1'
  gem.add_dependency 'gli', '~> 2.10'
  gem.add_dependency 'highline', '~> 2.0'
  gem.add_dependency 'slack-notifier', '~> 1.5.1'
  gem.add_dependency 'rack', '>= 2.1.4'
  gem.add_dependency 'activesupport', '~> 6.0'

  gem.add_development_dependency 'bundler', '~> 2.1'
  gem.add_development_dependency 'guard-rspec', '~> 4.3'
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rspec', '~> 3.9'
end
