module Tadpoll
  class Option < ::ActiveRecord::Base

    belongs_to :poll
    has_many :votes
    has_many :voters, :through => :votes

    # Create Option
    def self.new_option(name, poll_id)
      return false if name.blank?

      option = Tadpoll::Option.new(name: name, poll_id: poll_id)

      if option.save
        return option
      else
        return false
      end
    end

    # Vote 
    def vote(voter)
      return false if voter.nil?

      if self.voted_on_by?(voter)
        return false
      else 
        vote = Tadpoll::Vote.new(
          option: self,
          voter: voter,
          poll_id: self.poll_id
        )
      end

      if vote.save
        return true
      else
        return false
      end
    end

    # Destory Votes with given parameters
    def unvote(voter)
      return false if voter.nil?
      if self.voted_on_by?(voter)
        _votes_ = find_votes_for(voter)
        _votes_.each(&:destroy)
      end
      return true
    end

    # Votes with given parameters
    def find_votes_for(voter)
      votes.where(voter_id: voter.id)
    end

    # Count of Votes for an Option
    def vote_count
      votes.count
    end

    # T / F Has the Option been voted on
    def voted_on?
      votes.count > 0
    end

    # T / F Has this Option been voted on by given Voter
    def voted_on_by?(voter)
      votes = find_votes_for(voter)
      votes.count > 0
    end


  end
end