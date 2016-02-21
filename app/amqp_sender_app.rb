require_relative 'amqp_sender'

class AmqpSenderApp
  
  def initialize
    @amqp_sender = Sender.new(APP_CONFIG['amqp_connection'].merge('queue' => APP_CONFIG['queue']))
  end
  
  def call(env)
    @amqp_sender.send_message("Hello World!")
    [200, {}, ["Hello Rack"]]
  end
end