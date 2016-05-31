require 'spec_helper'

describe Tadpoll::Vote do

  before :each do
    poll = Tadpoll::Poll.create!(name: "New Poll")
    voter = Voter.create!
    option = Tadpoll::Option.create!(name: "New Option")
    @vote = Tadpoll::Vote.create!(poll: poll, voter: voter, option: option)
  end

  it "has the expected attributes" do
    expect(@vote).to be_valid
  end

end