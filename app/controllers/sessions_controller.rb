require 'github_api'

class SessionsController < ApplicationController
  def authorize
    oauth_url = github.authorize_url(
      redirect_uri: auth_callback_url(:github),
      scope: 'read:user'
    )
    redirect_to oauth_url
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'Signed out'
  end

  def callback
    token = github.get_token(params[:code]).token
    user = Github.new(oauth_token: token).users.get.body
    session.merge! token: token, user: {name: user.name}
    redirect_to github_home_url, notice: 'Signed in'
  end

  private

  def github
    @github ||= Github.new(
      client_id: Rails.application.config.github['client_id'],
      client_secret: Rails.application.config.github['client_secret']
    )
  end
end
