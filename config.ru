require 'rubygems'
require 'bundler'
Bundler.require
require_relative './config/load_config'
require './app/amqp_sender_app'

run Sender.new