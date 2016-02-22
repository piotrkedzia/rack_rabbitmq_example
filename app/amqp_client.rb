require 'bunny'

class MqClient

  def initialize(queue_name, options = {})
    @connection = Bunny.new(options['amqp_connection'])
    @connection.start
    @channel = @connection.create_channel
    @queue = @channel.queue(queue_name)
  end

  def send_message(message = 'hello!')
    @channel.default_exchange.publish(message, :routing_key => @queue.name)
  end

  def listen_and_print_messages
    begin
      puts " [*] Waiting for messages from <#{@queue.name}>.\n To exit press CTRL+C"
      @queue.subscribe(:block => true) do |delivery_info, properties, body|
        puts " [x] Received #{body}"
      end
    rescue Interrupt => _
      @connection.close
    end
  end

  def purge_queue
    @queue.purge
  end

  def unread_messages_count
    @queue.message_count
  end

  def close_connection
    @connection.close
  end

end