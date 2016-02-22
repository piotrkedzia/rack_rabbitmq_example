require 'spec_helper'
require 'rack/test'
require 'pry'
require 'capybara/rspec'
require './app/amqp_sender_app'
require './app/amqp_receiver'


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

  describe 'POST message' do
    let(:message) { 'example message' }
    let(:receiver) { Receiver.new(APP_CONFIG['queue'], APP_CONFIG['amqp_connection']) }

    before :each do
      receiver.purge_queue
    end

    after :each do
      receiver.purge_queue
    end

    context 'POST valid message' do

      before :each do
        post '/send_message', 'message' => message
      end

      it 'returns 201 code' do
        expect(last_response.status).to eq(201)
      end

      it 'increases number of messages' do
        expect(receiver.unread_messages_count).to eq(1)
      end
    end

    context 'POST invalid data' do
      before :each do
        post '/send_message', 'invalid_message_key' => message
      end

      it 'return 422 Unprocessable Entity code' do
        expect(last_response.status).to eq(422)
      end

      it "doesn't increase messages count" do
        expect(receiver.unread_messages_count).to eq(0)
      end
    end
  end

  describe 'GET invalid route' do
    before(:each) { get '/fake_route' }

    it 'return 404 Not Found status code' do
      expect(last_response.status).to eq(404)
    end

    it 'displays home page' do
      expect(last_response.body).to include('leave the message')
    end
  end

end