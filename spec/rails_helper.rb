# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Rails.application.load_tasks

RSpec.configure do |config|
  config.before :suite do
    ENV['CONFIG_FILE'] = Rails.root.join('config/slonik.yml').to_s
    ENV['VERBOSE'] = 'true'
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
  end
end
