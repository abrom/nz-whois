require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nz-whois'

require 'webmock/rspec'
require 'shoulda-matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
