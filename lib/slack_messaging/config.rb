module SlackMessaging
  class Config
    def self.config
      config_data.to_hash
    end

    def self.load(path)
      load_config(path)
      config
    end

    private

    def self.config_data
      @config_data ||= Hashie::Mash.new
    end

    def self.method_missing(method, args=false)
      config_data.send(method, args)
    end

    def self.load_config(file)
      raise MissingConfig, "Missing configuration file: #{file}" unless File.exist?(file)
      YAML.load_file(file).each { |key, value| config_data.assign_property(key, value) }
    end
  end
end
