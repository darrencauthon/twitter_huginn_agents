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

    describe "we saw three twitter followers previously" do

      before { agent.stubs(:previous_followers).returns previous_followers }

      let(:previous_followers) { [random_string, random_string, random_string] }

      describe "and one of the followers is no longer a follower" do

        let(:lost_follower) { previous_followers.sample }

        let(:current_followers) do
          previous_followers - [lost_follower]
        end

        before { agent.stubs(:current_followers).returns current_followers }

        it "should create an event stating that the follower was lost" do
          agent.expects(:create_event).with(payload: { follower: lost_follower } )
          agent.check
        end

      end

      describe "and all of the followers are still followers" do

        let(:current_followers) { previous_followers }

        before { agent.stubs(:current_followers).returns current_followers }

        it "should create an event stating that the follower was lost" do
          agent.stubs(:create_event).raises 'should not have been called'
          agent.check
        end

      end

      describe "and all of the followers have left" do

        let(:current_followers) { [] }

        before { agent.stubs(:current_followers).returns current_followers }

        it "should create an event for each lost follower" do
          agent.expects(:create_event).with(payload: { follower: previous_followers[0] } )
          agent.expects(:create_event).with(payload: { follower: previous_followers[1] } )
          agent.expects(:create_event).with(payload: { follower: previous_followers[2] } )
          agent.check
        end

      end

    end

  end

  describe "current followers" do

    let(:twitter_client) { Object.new }

    describe "there is only one page of items" do

      let(:page) do
        Struct.new(:to_hash).new( { ids: ids, next_cursor: next_cursor } )
      end

      let(:ids)         { [Object.new, Object.new, Object.new] }
      let(:next_cursor) { 0 }

      let(:twitter_username) { random_string }
      
      let(:results) { agent.current_followers }

      before do
        agent.stubs(:twitter_client).returns twitter_client
        agent.stubs(:twitter_username).returns twitter_username
        twitter_client.stubs(:follower_ids).with(twitter_username).returns page
      end

      it "should return the ids" do
        results.count.must_equal ids.count
        ids.each { |i| results.include?(i).must_equal true }
      end

    end

  end

end
