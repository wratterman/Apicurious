class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                 = auth_info[:uid]
      new_user.username            = auth_info[:extra][:raw_info][:login]
      new_user.name                = auth_info[:extra][:raw_info][:name]
      new_user.email               = auth_info[:extra][:raw_info][:email]
      new_user.profile_picture     = auth_info[:extra][:raw_info][:avatar_url]
      new_user.oauth_token         = auth_info[:credentials][:token]
      new_user.oauth_token_secret  = auth_info[:credentials][:secret]
    end
  end

  def get_account
    GithubService.find_account(self.oauth_token)
  end

  def get_starred_repos
    GithubService.find_starred(self.oauth_token, self.username)
  end

  def get_recent_commits
    GithubService.find_commits(self.oauth_token, self.username)
  end

  def get_followers
    GithubService.find_followers(self.oauth_token, self.username)
  end

  def get_following
    GithubService.find_who_i_follow(self.oauth_token, self.username)
  end

  def get_orgs
    GithubService.find_orgs(self.oauth_token, self.username)
  end

  def get_repos
    GithubService.find_repos(self.oauth_token, self.username)
  end
end
