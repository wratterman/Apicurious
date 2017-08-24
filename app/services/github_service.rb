class GithubService

  def initialize(token, user)
    @token = token
    @user  = user
    @conn  = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.authorization :Token, @token
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.find_account(token)
    new(token, nil).find_my_account
  end

  def self.find_commits(token, user)
    new(token, user).find_my_commits
  end

  def self.find_followers(token, user)
    new(token, user).find_my_followers
  end

  def self.find_who_i_follow(token, user)
    new(token, user).find_all_i_follow
  end

  def self.find_orgs(token, user)
    new(token, user).find_my_orgs
  end

  def self.find_repos(token, user)
    new(token, user).find_my_repos
  end

  def find_my_account
    get_url("/user?access_token=#{@token}")
  end

  def find_my_commits
    get_url("/users/#{@user}/events?access_token=#{@token}")
  end

  def find_my_followers
    get_url("users/#{@user}/followers?access_token=#{@token}")
  end

  def find_all_i_follow
    get_url("/users/#{@user}/following?access_token=#{@token}")
  end

  def find_my_orgs
    get_url("/users/#{@user}/orgs?access_token=#{@token}")
  end

  def find_my_repos
    get_url("/users/#{@user}/repos?access_token=#{@token}")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_name: true)
  end
end
