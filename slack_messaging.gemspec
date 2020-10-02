# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_messaging/version'

Gem::Specification.new do |spec|
  spec.name          = "slack_messaging"
  spec.version       = SlackMessaging::VERSION
  spec.authors       = ["Emma Sax"]
  spec.email         = ["emma.sax4@gmail.com"]
  spec.summary       = %q{Sending Personalized Slack Messages}
  spec.description   = %q{Sending Personalized Slack Messages}
  spec.homepage      = "https://github.com/emmasax4/slack_messaging"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'hashie', '~> 3.3'
  spec.add_dependency 'gli', '~> 2.10'
  spec.add_dependency 'highline', '~> 1.6'
  spec.add_dependency 'slack-notifier', '~> 1.5.1'
  spec.add_dependency 'rack', '>= 2.1.4'
  spec.add_dependency 'activesupport', '~> 4.1.11'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'guard', '~> 2.6'
  spec.add_development_dependency 'guard-rspec', '~> 4.3'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3'
end
