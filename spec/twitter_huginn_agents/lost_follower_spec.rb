require_relative '../spec_helper'

describe TwitterHuginnAgents::LostFollower do

  let(:agent) { TwitterHuginnAgents::LostFollower.new }

  it "should be a huginn agent" do
    agent.is_a?(HuginnAgent).must_equal true
  end

  it "should have a description" do
    TwitterHuginnAgents::LostFollower.description.must_equal 'Track lost followers on Twitter'
  end

  describe "check" do

    it "should exist" do
      agent.respond_to?(:check).must_equal true
    end

  end

end
