require 'yaml'
file_path = File.expand_path('../application.yml', __FILE__)
raw_config = File.read(file_path)
APP_CONFIG = YAML.load(raw_config)[ENV['RACK_ENV']]