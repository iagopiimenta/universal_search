# frozen_string_literal: true

Capybara.run_server = false
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium_chrome_headless
end
