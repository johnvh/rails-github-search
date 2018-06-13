class SessionsController < ApplicationController
  def authorize
    redirect_to GithubApi.app_client.authorize_url(
      redirect_uri: auth_callback_url(:github),
      scope: 'read:user'
    )
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'Signed out'
  end

  def callback
    oauth_token = GithubApi.app_client.get_token(params[:code]).token
    user = GithubApi.client(oauth_token).users.get.body

    session.merge! token: oauth_token, user: {name: user.name}
    redirect_to github_home_url, notice: 'Signed in'
  end
end
