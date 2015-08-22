module TwitterHuginnAgents
  class LostFollower < HuginnAgent
    def self.description
      'Track lost followers on Twitter'
    end

    def check
      if lost_follower = (previous_followers - current_followers)[0]
        create_event payload: { lost_follower: lost_follower }
      end
    end
  end
end
