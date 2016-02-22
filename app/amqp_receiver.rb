require "bunny"
require 'pry'
require 'pry-byebug'

class Receiver
  
  def initialize(queue_name = 'oracle_inbox', options = {})
    @conn = Bunny.new(options)
    @conn.start
    @ch = @conn.create_channel
    @q = @ch.queue(queue_name)
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
    puts "Messages before purge: #{@q.message_count}"
    @q.purge
    puts "Messages after purge: #{@q.message_count}"
  end
  
  def unread_messages_count
    @q.message_count
  end
  
  def close_connection
    @conn.close
  end
end


if ARGV.include? 'run'
  Receiver.new(ARGV[0]).listen_messages
end
