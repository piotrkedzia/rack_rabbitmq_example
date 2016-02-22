ENV['RACK_ENV'] = 'development'
require_relative 'amqp_client'
require_relative '../config/load_config'

queue = ARGV.first ? ARGV.first.to_s : APP_CONFIG['queue']

amqp_client = MqClient.new(queue, APP_CONFIG['amqp_connection'])

amqp_client.listen_and_print_messages