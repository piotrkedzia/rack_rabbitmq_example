require 'spec_helper'
require 'rack/test'
require './app/amqp_sender_app'
require 'pry'
require 'capybara/rspec'

describe "AMQP Sender rack app" do
  include Rack::Test::Methods
  include Capybara::RSpecMatchers
  
  def app
    AmqpSenderApp.new
  end
  
  describe 'GET home page' do
    before :each do
      get '/'
    end
    it 'has proper welcome text' do  
      expect(last_response.body).to include("leave the message")
    end
    
    it 'returns proper request code' do
      last_response.status == 200
    end
    
    it 'has send form' do
      expect(last_response.body).to have_selector('form')
    end
    
    it 'has submit button' do
      expect(last_response.body).to have_button('Submit')
    end
    
    it 'has input message input field' do
      expect(last_response.body).to have_field('message')
    end
    
  end
  
end