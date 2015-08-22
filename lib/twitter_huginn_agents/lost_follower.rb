module TwitterHuginnAgents
  class LostFollower < HuginnAgent
    def self.description
      'Track lost followers on Twitter'
    end

    def check
      create_event payload: { lost_follower: (previous_followers - current_followers)[0] }
    end
  end
end
