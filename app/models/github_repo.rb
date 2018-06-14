class GithubRepo
  def self.for_token(oauth_token)
    GithubRepo.new GithubApi.client(oauth_token)
  end

  def initialize(client)
    @client = client
  end

  def search(query:, page: 1, per_page: 20)
    @client.search.repos q: query, page: page, per_page: per_page
  end
end
