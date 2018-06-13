require 'github_api'

module GithubApi
  extend self

  def app_client
    @github ||= Github.new(
      client_id: Rails.application.config.github['client_id'],
      client_secret: Rails.application.config.github['client_secret']
    )
  end

  def client(oauth_token)
    Github.new(oauth_token: oauth_token)
  end
end
