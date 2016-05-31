require 'spec_helper'

describe Tadpoll::Option do

  before :each do
    @poll = Tadpoll::Poll.create!(name: "New Poll")
    @option = Tadpoll::Option.create!(name: "Option 1", poll: @poll)
    @voter = Voter.create!
    @vote = Tadpoll::Vote.create!(poll: @poll, voter: @voter, option: @option)
  end

  it "has the expected attributes" do 
    expect(@option).to be_valid
  end

  it ".new_option has the expected attributes" do
    option = Tadpoll::Option.new_option("New Option", @poll.id)
    expect(option).to be_valid
  end

  it "#vote with new voter" do
    new_voter = Voter.create!
    expect(@option.vote(new_voter)).to be true
  end

  it "doesnt #vote with repeat voter" do
    expect(@option.vote(@voter)).to be false
  end

  it "counts votes" do
    expect(@option.vote_count).to eql(1)
  end

  it "#unvote for given voter" do 
    @option.unvote(@voter)
    expect(@option.vote_count).to eql(0)
  end

  it "#find_votes_for given voter" do
    expect(@option.find_votes_for(@voter).count).to eql(1)
  end

  it "#voted_on" do
    expect(@option.voted_on?).to be true
  end

  it "#voted_on_by a voter who voted" do 
    expect(@option.voted_on_by?(@voter)).to be true
  end

  it "not #voted_on_by a voter who didnt vote" do
    new_voter = Voter.create!
    expect(@option.voted_on_by?(new_voter)).to be false
  end
  
end