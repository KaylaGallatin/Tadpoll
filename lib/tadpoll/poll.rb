module Tadpoll
  class Poll < ::ActiveRecord::Base

    has_many :options, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :voters, :through => :votes

    validates_presence_of :name

    # Create new poll with option
    def self.create_poll_with_options(name, options = [])
      return false if name.blank?

      poll = Tadpoll::Poll.new(name: name)

      if poll.save
        poll.create_options(poll, options)
        return poll
      else
        return false
      end
    end

    # Create new option for a poll
    def create_options(poll, options = [])
      if options.any?
        options.each do |option|
          Tadpoll::Option.new_option(option, poll.id)
        end
      end
    end

    # Remove vote from poll for given voter
    def unvote(voter)
      return false if voter.nil?
      if self.voted_on_by?(voter)
        _votes_ = find_votes_for({voter_id: voter.id})
        _votes_.each(&:destroy)
      end
      return true
    end

    # Votes with given parameters
    def find_votes_for(args = {})
      votes.where(args)
    end

    # T / F Has this Poll been voted on
    def voted_on?
      votes.count > 0
    end

    # T / F Has this Poll been voted on by given Voter
    def voted_on_by?(voter)
      votes = find_votes_for({voter_id: voter.id})
      votes.count > 0
    end

  end
end