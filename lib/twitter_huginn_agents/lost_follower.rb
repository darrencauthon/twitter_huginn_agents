module TwitterHuginnAgents
  class LostFollower < HuginnAgent
    def self.description
      'Track lost followers on Twitter'
    end

    def check
      (previous_followers - current_followers).each do |follower|
        create_event payload: { lost_follower: follower }
      end
    end
  end
end
