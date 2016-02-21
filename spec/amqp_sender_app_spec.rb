require 'spec_helper'
require 'rack/test'
require './app/amqp_sender_app'

describe "Sender rack app" do
  include Rack::Test::Methods
  
  def app
    Sender.new
  end
  
  describe 'GET home page' do
    before :each do
      get '/'
    end
    it 'returns home page' do  
      expect(last_response).to include("leave the message")
    end
    
    it 'returns proper request code' do
      last_response.status == 200
    end
    
    it 'returns send form' do
      last_response.should have_tag("form")
    end
    
  end
  
end