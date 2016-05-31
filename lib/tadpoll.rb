require 'active_record'
require 'active_support/inflector'

$LOAD_PATH.unshift(File.dirname(__FILE__))

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
 
end

require 'tadpoll/extenders/controller'
ActiveSupport.on_load(:action_controller) do
  include Tadpoll::Extenders::Controller
end