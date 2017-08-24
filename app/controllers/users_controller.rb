class UsersController < ApplicationController

  def show
    @user = current_user.get_account
  end
end
