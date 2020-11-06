require "bundler/setup"
require "ramsey_cop"

require "rubocop/rspec/support"

require "support/shared_contexts"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RuboCop::RSpec::ExpectOffense
end
