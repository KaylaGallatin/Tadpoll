require 'active_record'
require 'active_support/inflector'

module Tadpoll 

  if defined?(ActiveRecord::Base)
    require 'tadpoll/version'
    require 'tadpoll/option'
    require 'tadpoll/poll'
    require 'tadpoll/vote'
    require 'tadpoll/voter'
    require 'tadpoll/extenders/voter'
    ActiveRecord::Base.extend Tadpoll::Extenders::Voter
  end

  def self.polls
    Tadpoll::Poll.all
  end
 
end

require 'tadpoll/extenders/controller'
ActiveSupport.on_load(:action_controller) do
  include Tadpoll::Extenders::Controller
end