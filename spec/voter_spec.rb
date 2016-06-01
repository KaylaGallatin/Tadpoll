require 'spec_helper'

describe Tadpoll::Voter do

  before :each do
    @poll = Tadpoll::Poll.create!(name: "New Poll")
    @option = Tadpoll::Option.create!(name: "Option 1", poll: @poll)
    @voter = User.create!
    @vote = Tadpoll::Vote.create!(poll: @poll, voter_id: @voter.id, voter_type: @voter.class.base_class.name, option: @option)
  end

  it "should be a voter" do
    expect(User).to be_voter
  end

  it "has the expected attributes" do
    expect(@voter).to be_valid
  end

  it "#vote_for new option" do
    new_voter = User.create!
    expect(new_voter.vote_for(@option)).to be true
  end

  it "doesnt #vote_for voted option" do
    expect(@voter.vote_for(@option)).to be false
  end

  it "#unvote_for_option voted option" do
    expect(@voter.unvote_for_option(@option)).to be true
  end

  it "#unvote_for_poll voted poll" do
    expect(@voter.unvote_for_poll(@poll)).to be true
  end

  it "#unvote_for_option unvoted option" do
    unvoted_option = Tadpoll::Option.create!(name: "Unvoted Option", poll: @poll)
    expect(@voter.unvote_for_option(unvoted_option)).to be true
  end

  it "#unvote_for_poll unvoted poll" do
    unvoted_poll = Tadpoll::Poll.create!(name: "Unvoted Poll")
    expect(@voter.unvote_for_poll(unvoted_poll)).to be true
  end

  it "#voted_on_poll voted poll" do
    expect(@voter.voted_on_poll?(@poll)).to be true
  end

  it "#voted_on_option voted option" do
    expect(@voter.voted_on_option?(@option)).to be true
  end

end