require_relative '../spec_helper'

describe TwitterHuginnAgents::LostFollower do

  let(:agent) { TwitterHuginnAgents::LostFollower.new }

  it "should be a huginn agent" do
    agent.is_a?(HuginnAgent).must_equal true
  end

end
