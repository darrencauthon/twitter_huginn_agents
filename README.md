# Twitter Huginn Agents

Agents that could help 

## Installation

Add this line to your Huginn app's Gemfile:

```ruby
gem 'twitter_huginn_agents'
```

And then execute:

    $ bundle

Restart your Huginn app.  You should see this gem's agents in your list of available agents.

## Usage

To use these agents, you will need an API key from Twitter.  Go to http://apps.twitter.com,
then press the button to create a new app.

After creating the application, Twitter will give you a "Consumer Key/API Key" and a
"Consumer Secret (API Secret)".  You'll need these two things to use these agents.

### LostFollowerAgent

This agent will let you konw if someone unfollows you on Twitter.  Required data is:

```
consumer_key     # your Twitter consumer key
consumer_secret  # your Twitter consumer secret
twitter_username # the Twitter username that will be tracked
```

If someone unfollows you on Twitter, an event will be fired.  The fired event will
contain all of the data that the Twitter API offers (look at the example on this
page: https://dev.twitter.com/rest/reference/get/users/lookup). The variable you
probably care about the most is "screen_name".






## Contributing

1. Fork it ( https://github.com/[my-github-username]/twitter_huginn_agents/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
