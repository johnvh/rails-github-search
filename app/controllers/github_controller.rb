require 'github_api'

class GithubController < ApplicationController
  def home
    repos = github.search.repos(q: params[:query], per_page: 3) if params[:query].present?
    @repos = repos ? repos.body.items : []
  end

  private

  def github
    @github ||= Github.new oauth_token: session['token']
  end
end
