class UsersController < ApplicationController

  def show
    @user = current_user.get_account
    @starred = current_user.get_starred_repos
    @commits = current_user.get_recent_commits
    @followers = current_user.get_followers
    @following = current_user.get_following
    @orgs = current_user.get_orgs
    @repos = current_user.get_repos
  end
end
