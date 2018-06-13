class GithubController < ApplicationController
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
end
