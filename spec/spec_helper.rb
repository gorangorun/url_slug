# frozen_string_literal: true

require 'url_slug'
require 'rails/generators'
require 'generators/url_slug/install_generator'
require 'generators/url_slug/rails/rails_generator'
require 'support/generator_spec_helpers'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
