require 'json_spec'
require 'rspec/collection_matchers'

require_relative 'support/helpers'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Helpers, type: :controller

  CarrierWave.configure do |c|
    c.enable_processing = false
  end
end
