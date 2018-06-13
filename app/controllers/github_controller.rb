class GithubController < ApplicationController
  before_action :authenticate

  def home
    @repos = if params[:query].present?
               GithubApi.client(session['token']).search.repos(
                 q: params[:query],
                 per_page: 3
               ).body.items
             else
               []
             end
  end

  private

  def authenticate
    redirect_back(fallback_location: root_url) unless logged_in?
  end
end
