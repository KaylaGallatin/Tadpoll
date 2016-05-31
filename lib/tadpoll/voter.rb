module Tadpoll
  module Voter 

    def self.included(base)
      base.class_eval do
        has_many :votes, :class_name => 'Tadpoll::Vote', :dependent => :destroy 
      end
    end

    # Vote for an option
    def vote_for(option)
      option.vote(self)
    end

    # Unvote for an option
    def unvote_for_option(option)
      option.unvote(self)
    end

    # Unvote for a poll
    def unvote_for_poll(poll)
      poll.unvote(self)
    end

    # T / F votes for given params
    def voted_on?(args = {})
      found_votes = votes.where(args)
      found_votes.count > 0
    end

    # T / F Voter voted on given poll
    def voted_on_poll?(poll)
      voted_on?({poll_id: poll.id})
    end

    # T / F Voter voted for given option
    def voted_on_option?(option)
      voted_on?({poll_id: option.poll_id, option_id: option.id})
    end

  end
end