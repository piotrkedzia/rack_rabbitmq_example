require_relative 'amqp_sender'
require 'erb'
class AmqpSenderApp

  def initialize
    @amqp_sender = Sender.new(APP_CONFIG['queue'], APP_CONFIG['amqp_connection'])
  end

  def call(env)
    request = Rack::Request.new(env)
    case request.path
    when '/' then Rack::Response.new(render('index.html.erb'), 200)
    when '/send_message'

      unless request.post?
        return redirect_to_root(400)
      end

      if request.params['message']
        @amqp_sender.send_message(request.params['message'])
        Rack::Response.new(render('message_sent.html.erb'), 201)
      else
        redirect_to_root 422
      end
    else redirect_to_root 404
    end
  end

  private

  def redirect_to_root(status_code)
    Rack::Response.new(render('index.html.erb'), status_code).finish
  end

  def render(template)
    path = File.expand_path("../../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
end