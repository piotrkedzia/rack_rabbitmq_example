require 'yaml'

raw_config = File.read('./config/application.yml')
APP_CONFIG = YAML.load(raw_config)[ENV['RACK_ENV']]