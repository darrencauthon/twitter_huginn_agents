module TwitterHuginnAgents
  class LostFollower < HuginnAgent
    def self.description
      'Track lost followers on Twitter'
    end

    def check
      (previous_followers - current_followers).each do |follower|
        create_event payload: { follower: follower }
      end
      memory[:followers] = current_followers
    end

    def current_followers
      twitter_client.follower_ids(twitter_username).to_hash[:ids]
    end

    def previous_followers
      memory[:followers] || []
    end

    def twitter_username
      options[:twitter_username]
    end

    def default_options
      {
        consumer_key: '',
        consumer_secret: '',
        twitter_username: '',
      }
    end
  end
end
