require 'rspec'
require 'webmock/rspec'

require 'hookly'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.run_all_when_everything_filtered = true
  config.profile_examples = 10
  config.order = :defined
  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one? # More verbose when focused on one file
end

WebMock.disable_net_connect!

Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each do |file|
  require file
end
