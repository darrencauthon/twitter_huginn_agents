require 'twitter'

module TwitterHuginnAgents
  class LostFollower < HuginnAgent
    def self.description
      'Track lost followers on Twitter'
    end

    def check
      (previous_followers - current_followers).each do |follower|
        create_event payload: twitter_client.user(follower).to_hash
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

    def twitter_client
      ::Twitter::REST::Client.new do |config|
        config.consumer_key    = options[:consumer_key]
        config.consumer_secret = options[:consumer_secret]
      end
    end

    def validate_options
      errors.add :base, 'you must provide your Twitter consumer key' if options['consumer_key'].to_s.strip == ''
      errors.add :base, 'you must provide your Twitter consumer secret' if options['consumer_secret'].to_s.strip == ''
      errors.add :base, 'you must provide your Twitter username' if options['twitter_username'].to_s.strip == ''
    end
  end
end
