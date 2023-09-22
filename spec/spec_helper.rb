require 'bundler/setup'
require 'simplecov'
SimpleCov.start
require 'rspec'
require 'omniauth'
require 'omniauth-azure-devops'

OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.extend OmniAuth::Test::StrategyMacros, :type => :strategy
end

