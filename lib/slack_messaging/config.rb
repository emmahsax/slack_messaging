# frozen_string_literal: true

module SlackMessaging
  class Config
    class << self
      def method_missing(method, args = false)
        config_data.send(method, args)
      end

      def load(path)
        load_config(path)
        config
      end

      private def config
        config_data.to_hash
      end

      private def config_data
        @config_data ||= Hashie::Mash.new
      end

      private def load_config(file)
        raise StandardError, "Missing configuration file: #{file}" unless File.exist?(file)

        YAML.load_file(file).each { |key, value| config_data.assign_property(key, value) }
      end
    end
  end
end
