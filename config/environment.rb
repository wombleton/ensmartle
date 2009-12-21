# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => '_melee_session',
    :secret      => '54652575357e2d08daec3067d0a0a61173d855483a654b2f2485fefb2c665fa948d90f1b0e22c6da06c1c22ab0a823b6c11554bf7362756b9b82f22f95934aef'
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