module Tadpoll
  class Vote < ::ActiveRecord::Base

    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :voter_id, :voter_type
    end

    belongs_to :voter
    belongs_to :poll
    belongs_to :option

    validates_presence_of :voter_id
    validates_presence_of :poll_id
    validates_presence_of :option_id

  end
end