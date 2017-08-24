require 'rails_helper'

describe GithubService do
  describe "Users" do
    it "finds account for current user" do
      VCR.use_cassette("services/find_account") do
        user = GithubService.find_account(ENV['GITHUB_KEY'])
        expect(user[:name]).to eq("Will Ratterman")
      end
    end
  end
end
