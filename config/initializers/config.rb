require 'yaml'

config_file = File.expand_path('../../../config/config.yml', __FILE__)
if File.exists?(config_file)
  YAML.load_file(config_file).each_pair do |key, value|
    ENV[key.upcase] = value
  end
end
