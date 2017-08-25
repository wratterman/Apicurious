class Users::RepositoriesController < ApplicationController

   def index
     @repos = current_user.get_repos
   end
end
