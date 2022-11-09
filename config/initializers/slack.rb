Slack.configure do |config|
  config.token = Figaro.env.SLACK_API_TOKEN
end
