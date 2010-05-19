require 'rspec/core'

module FixtureExampleGroupBehaviour
  extend ActiveSupport::Concern
  included do
    if RSpec.configuration.use_transactional_examples
      extend  RSpec::Rails::SetupAndTeardownAdapter
      include RSpec::Rails::TestUnitAssertionAdapter
      include ActiveRecord::TestFixtures 
      self.fixture_path = RSpec.configuration.fixture_path 
      fixtures RSpec.configuration.global_fixtures unless RSpec.configuration.global_fixtures.nil?
    end 
  end
end

RSpec.configure do |c|
  c.include FixtureExampleGroupBehaviour
end

