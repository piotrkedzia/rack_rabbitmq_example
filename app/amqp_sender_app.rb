class Sender
    
  def call(env)
    [200, {}, ["Hellor Rack"]]
  end
end