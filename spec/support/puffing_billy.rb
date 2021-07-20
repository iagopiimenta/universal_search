require 'billy/capybara/rspec'

Billy.configure do |c|
  c.cache = true
  c.persist_cache = true
  c.cache_path = 'spec/req_cache/'
end
