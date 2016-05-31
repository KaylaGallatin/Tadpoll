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

poll = Tadpoll::Poll.create_poll_with_options("Best Fruit", ["Orange", "Banana"])
option = poll.options.first
@user.vote_for(option)

@user.voted_on_option?(option) # => true
@user.voted_on_poll?(poll) # => true
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

