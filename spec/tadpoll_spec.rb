require 'spec_helper'

describe Tadpoll do

  before :each do
    @poll = Tadpoll::Poll.create!(name: "New Poll")
  end

  it "should have polls" do
    expect(Tadpoll.polls.count).to be > 0
  end
  
end