# Tadpoll

Tadpoll is a Ruby Gem designed to easily create polls with mutually exclusive options for voters to vote on.

## Installation

Add the following to your application's Gemfile:

```ruby
gem 'tadpoll'
```

Followed by a ``bundle install``.

### Database Migrations

Tadpoll uses 3 tables: Vote, Poll, and Option to store all voting information.  To
generate and run the migration do:

    rails generate tadpoll:migration
    rake db:migrate

## Usage

### Voter Models

```ruby
class User < ActiveRecord::Base
  is_voter
end

poll = Tadpoll::Poll.create_poll_with_options("Best P&R Character", ["Leslie Knope", "Ron Swanson"])
option = poll.options.first
@user.vote_for(option)

@user.voted_on_option?(option) # => true
@user.voted_on_poll?(poll) # => true

@user.unvote_for_poll(poll)
@user.voted_on_option?(option) # => false
@user.voted_on_poll?(poll) # => false
```

### Polls

Polls have a name, and mutually exclusive options for voter models to vote on.

```ruby
# create a poll with options
poll = Tadpoll::Poll.create_poll_with_options("Best Star Wars Character", ["Han Solo", "Leia Organa"])
poll.create_options(["Luke Skywalker"])
poll.options.map{|o| o.name} # => ["Han Solo", "Leia Organa", "Luke Skywalker"]

# voter models can vote for options on a poll
option = poll.options.first
@user.vote_for(option)

poll.voted_on? # => true
poll.voted_on_by?(@user) # => true

# remove votes for a user
poll.unvote(@user)
poll.voted_on_by?(@user) # => false
```

### Options

Options belong to individual polls, and have many votes. 

```ruby
# create a poll and add new options
poll = Tadpoll::Poll.create_poll_with_options("Best GoT Character", ["Jon Snow", "Brienne of Tarth"])
Tadpoll::Option.new_option("Arya Stark", poll.id)
poll.options.map{|o| o.name} # => ["Jon Snow", "Brienne of Tarth", "Arya Stark"]

# vote on options
option = poll.options.first
option.vote(@user)

option.vote_count # => 1
option.voted_on? # => true
option.voted_on_by?(@user) # => true

# remove user votes
option.unvote(@user)
option.voted_on_by?(@user) # => false
```

## Testing

All tests are located in the spec directory and follow the RSpec format.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

