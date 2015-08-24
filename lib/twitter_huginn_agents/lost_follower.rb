require 'twitter'

module TwitterHuginnAgents

  class LostFollower < HuginnAgent

    def self.description
      'Track lost followers on Twitter'
    end

    def check
      fire_an_event_for_any_new_unfollowers
      store_the_current_list_of_follows_for_the_next_check
    end

    def default_options
      {
        consumer_key:     '',
        consumer_secret:  '',
        twitter_username: '',
      }
    end

    def validate_options
      errors.add :base, 'you must provide your Twitter consumer key' if options['consumer_key'].to_s.strip == ''
      errors.add :base, 'you must provide your Twitter consumer secret' if options['consumer_secret'].to_s.strip == ''
      errors.add :base, 'you must provide your Twitter username' if options['twitter_username'].to_s.strip == ''
    end

    def twitter_client
      ::Twitter::REST::Client.new do |config|
        config.consumer_key    = options[:consumer_key]
        config.consumer_secret = options[:consumer_secret]
      end
    end

    def twitter_username
      options[:twitter_username]
    end

    def current_followers
      twitter_client.follower_ids(twitter_username).to_hash[:ids]
    end

    def followers_who_were_not_here_at_last_check
      previous_followers - current_followers
    end

    def user_data_for id
      twitter_client.user(id).to_hash
    end

    def previous_followers
      memory[:followers] || []
    end

    private

    def fire_an_event_for_any_new_unfollowers
      followers_who_were_not_here_at_last_check.each do |follower|
        create_event payload: user_data_for(follower)
      end
    end

    def store_the_current_list_of_follows_for_the_next_check
      memory[:followers] = current_followers
    end

  end

end
