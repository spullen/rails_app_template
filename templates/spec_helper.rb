# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'rspec/autorun'

Capybara.javascript_driver = :poltergeist
Capybara.match = :first

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  
  config.include Rails.application.routes.url_helpers
  config.include ActionView::Helpers::NumberHelper
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods # allows you to do create(:something) instead of FactoryGirl.create(:something)
  config.include Devise::TestHelpers, :type => :controller
  config.include ApplicationHelper
  
  config.filter_run :focus => true # aka wip, add this to any describe or it block options
  config.run_all_when_everything_filtered = true
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  
  config.before(:each) do
    ActionMailer::Base.deliveries = []
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end