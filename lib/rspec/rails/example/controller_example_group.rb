require 'active_support/core_ext/class/attribute_accessors'
require 'action_controller'
require 'action_dispatch'
require 'webrat'
require 'test/unit/assertions'

# BEGIN PATCH
#
# This has been merged to rails HEAD after the 3.0.0.beta.3 release (see
# https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/4433).
# Once 3.0.0.rc.1 comes out, we can remove it.


require 'action_controller/test_case'
# END PATCH

# Preliminary documentation (more to come ....):
#
#   allow_forgery_protection is set to false
#   - you can set it to true in a before(:each) block
#     if you have a specific example that needs it, but
#     be sure to restore it to false (or supply tokens
#     to all of your example requests)

module Rspec::Rails::ActiveSupportConcernAdapter
  def setup(*methods)
    methods.each {|method| before { send method } }
  end

  def teardown(*methods)
    methods.each {|method| after { send method } }
  end
end

module ControllerExampleGroupBehaviour
  include Test::Unit::Assertions
  include Webrat::Matchers
  include Webrat::Methods
  include Rspec::Matchers

  def self.included(mod)
    mod.extend   Rspec::Rails::ActiveSupportConcernAdapter
    mod.__send__ :include, ActionController::TestCaseBehavior

    def mod.controller_class
      describes
    end

    mod.before do
      @routes = Rails.application.routes
      @_result = Struct.new(:add_assertion).new
      ActionController::Base.allow_forgery_protection = false
    end
  end
end

Rspec.configure do |c|
  c.include ControllerExampleGroupBehaviour, :example_group => {
    :describes => lambda {|described| described < ActionController::Base }
  }
end
