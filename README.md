Rack RabbitMQ example
======

## About the app

This repository contains pure Rack application which is acting as the forwarder of the messages between web user and RabbitMQ server. To send message use HTML root_page or send them direct through HTTP POST method.

To pull messages from RabbitMQ server you can use simple ruby script (amqp_listener.rb) from command line.

## Technology stack

* Rack 1.6.4
* Ruby 2.2.4
* Bunny 2.2.2
* Rspec 3.4.0
* Capybara 2.6.3
* Rack-test 0.6.3

## System Setup
You need RabbitMQ server installed on your system.

Check out the official [RabbitMQ](https://www.rabbitmq.com/download.html) documentation.

## Project setup

Go to project directory

 * run bundle install
 * copy `config/application.yml.sample` to `config/application.yml`
 * in `application.yml` you can set your RabbitMQ-server configuration options but it should works on default values
 
### Development

* make sure your rabbitmq-server is working if not run it with admin privileges. On Ubuntu OS it looks like: 
```
$ sudo rabbitmq-server start
```
* run rack server based on config.ru
```
$ rackup
```
* run listener script
```
$ ruby app/amqp_listener.rb 
```
* run tests
  ```
  $ rspec spec
  ```

### Contributing

First, thank you for contributing!

Here a few guidelines to follow:

1. Write tests
2. Make sure the entire test suite passes
3. Open a pull request on GitHub
