require 'bunny'

class MqClient
  
  def initialize(queue_name, options = {})
    @conn = Bunny.new(options['amqp_connection'])
    @conn.start
    @ch = @conn.create_channel
    @q = @ch.queue(queue_name)
  end
  
  def send_message(message = 'hello!')
    @ch.default_exchange.publish(message, :routing_key => @q.name)
  end
  
  def listen_messages
    begin
      puts " [*] Waiting for messages from <#{@q.name}>.\n To exit press CTRL+C"
      @q.subscribe(:block => true) do |delivery_info, properties, body|
        puts " [x] Received #{body}"
      end
    rescue Interrupt => _
      @conn.close
    end
  end
  
  def purge_queue
    @q.purge
  end
  
  def unread_messages_count
    @q.message_count
  end
  
  def close_connection
    @conn.close
  end

end