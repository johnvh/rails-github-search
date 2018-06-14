class GithubController < ApplicationController
  before_action :authenticate
  helper_method :permitted_params, :current_page_num, :next_page_num, :prev_page_num

  def home
    @repos = if permitted_params[:query].present?
               GithubRepo.for_token(session[:token]).search(
                 permitted_params.to_h.symbolize_keys
               )
             else
               nil
             end
  end

  private

  def permitted_params
    params.permit(:query, :page)
  end

  def current_page_num
    permitted_params[:page].to_i || 1
  end

  def next_page_num
    current_page_num + 1
  end

  def prev_page_num
    [1, current_page_num - 1].max
  end

  def authenticate
    redirect_back(fallback_location: root_url) unless logged_in?
  end
end
