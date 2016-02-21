require 'rubygems'
require 'bundler'
Bundler.require
require './app/amqp_sender_app'

run Sender.new