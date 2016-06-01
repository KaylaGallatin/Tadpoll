require 'spec_helper'

describe Tadpoll::Poll do

  before :each do
    @poll = Tadpoll::Poll.create!(name: "New Poll")
    @option = Tadpoll::Option.create!(name: "Option 1", poll: @poll)
    @voter = User.create!
    @vote = Tadpoll::Vote.create!(poll: @poll, voter: @voter, option: @option)
  end

  it "has the expected attributes" do
    expect(@poll).to be_valid
  end

  it "creates poll without options" do 
    test_poll = Tadpoll::Poll.create_poll_with_options("New Poll")
    expect(test_poll).to be_valid
  end

  it "#create_poll_with_options" do 
    test_poll = Tadpoll::Poll.create_poll_with_options("New Poll", ["option1", "option2"])
    expect(test_poll).to be_valid
  end

  it "#voted_on?" do
    expect(@poll.voted_on?).to be true
  end

  it "#voted_on_by" do
    expect(@poll.voted_on_by?(@voter)).to be true
  end

  it "#find_votes_for" do
    expect(@poll.find_votes_for({voter_id: @voter.id}).count).to eql(1)
  end

  it "#unvote" do
    @poll.unvote(@voter)
    expect(@poll.voted_on?).to be false
  end

  it "has options" do
    expect(@poll.options.first.name).to eq("Option 1")
  end

end