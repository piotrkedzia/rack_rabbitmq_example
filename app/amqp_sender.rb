require 'bunny'

class Sender
  def initialize(options = {})
    binding.pry
    @conn = Bunny.new(options['amqp_connection'])
    @conn.start
    @ch = @conn.create_channel
    @q = @ch.queue(options['queue'])
  end
  
  def send_message(message = 'hello!')
    @ch.default_exchange.publish(message, :routing_key => @q.name)
  end
end