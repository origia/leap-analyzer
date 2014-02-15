require 'bundler/setup'
require 'json'
Bundler.require(:default)

Mongoid.load!(File.expand_path('../mongoid.yml', __FILE__))

Mongoid.logger.level = Logger::DEBUG
Moped.logger.level = Logger::DEBUG

app_root = File.expand_path('../../app', __FILE__)
Dir.glob(app_root + '/**/*.rb', &method(:require))
