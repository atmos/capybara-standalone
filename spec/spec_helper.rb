require 'rspec'
require 'capybara'
require 'capybara/dsl'

module CapybaraStandalone
  def self.setup
    Capybara.configure do |config|
      config.app_host       = ENV['CAPYBARA_TEST_URL'] || 'http://localhost:3000'
      config.run_server     = false
      config.default_driver = :selenium
    end
  end
end

RSpec.configure do |config|
  config.include Capybara

  config.before(:all) do
    CapybaraStandalone.setup
  end
  config.after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
