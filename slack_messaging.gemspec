require File.expand_path('../lib/slack_messaging/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'slack_messaging'
  gem.version       = SlackMessaging::VERSION
  gem.authors       = ['Emma Sax']
  gem.email         = ['emma.sax4@gmail.com']
  gem.summary       = %q{Personalized Slack Messages}
  gem.description   = %q{Sending Personalized Slack Messages to a Slack channel of your choice.}
  gem.homepage      = 'https://github.com/emmasax4/slack_messaging'
  gem.license       = 'MIT'

  gem.executables   = Dir['bin/*'].map{ |f| File.basename(f) }
  gem.files         = Dir['lib/slack_messaging/*.rb'] + Dir['lib/*.rb'] + Dir['bin/*']
  gem.files         += Dir['[A-Z]*'] + Dir['test/**/*']
  gem.files.reject! { |fn| fn.include? '.gem' }
  gem.test_files    = Dir['spec/spec_helper.rb'] + Dir['spec/slack_messaging/*.rb']
  gem.require_paths = ['lib']

  gem.add_dependency 'activesupport', '~> 6.0'
  gem.add_dependency 'gli', '~> 2.10'
  gem.add_dependency 'hashie', '~> 4.1'
  gem.add_dependency 'highline', '~> 2.0'
  gem.add_dependency 'httparty', '~> 0.18'
  gem.add_dependency 'json', '~> 2.5'
  gem.add_dependency 'rack', '~> 2.2'

  gem.add_development_dependency 'bundler', '~> 2.2'
  gem.add_development_dependency 'faker', '~> 2.15'
  gem.add_development_dependency 'guard-rspec', '~> 4.3'
  gem.add_development_dependency 'pry', '~> 0.13'
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rspec', '~> 3.9'
end
