# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require 'yaml'

db = YAML.load_file('config/database.yml')

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => db[RAILS_ENV]['session_key'],
    :secret      => db[RAILS_ENV]['secret']
  }

  config.gem "treetop"
  config.gem "will_paginate"
  config.gem "ruby-openid", :lib => "openid"
  config.gem "authlogic"
  config.gem "authlogic-oid", :lib => "authlogic_openid"
  config.gem "haml"
  config.gem "twitter"
end

ConsumerConfig = YAML.load(File.read(File.join(RAILS_ROOT, 'config', 'consumer.yml')))

# monkeypatch in Time.ms for milliseconds on a time
Time.instance_eval do
  def from_ms ms
    Time.at(ms / 1000, (ms % 1000) * 1000)
  end
end
Time.class_eval do
  def to_ms
    self.to_i * 1000 + self.usec / 1000
  end

  def bump millis = 1
    Time.from_ms(self.to_ms + millis)
  end
end

