require 'rubygems'
require 'bundler'
Bundler.require
require_relative './config/load_config'
require './app/amqp_sender_app'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

run AmqpSenderApp.new