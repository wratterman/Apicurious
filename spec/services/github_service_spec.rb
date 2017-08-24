require 'rails_helper'

describe GithubService do
  describe "Users" do
    it "finds account for current user" do
      VCR.use_cassette("services/find_account") do
        user = GithubService.find_account(ENV['GITHUB_KEY'])

        expect(user["name"]).to eq("Will Ratterman")
        expect(user["login"]).to eq("wratterman")
      end
    end

    it "finds recent commits for current user" do
      VCR.use_cassette("services/find_recent_commits") do
        commits = GithubService.find_commits(ENV['GITHUB_KEY'], "wratterman")

        expect(commits[:name]).to eq("Will Ratterman")
      end
    end

    it "finds who current user is following" do
      VCR.use_cassette("services/find_following") do
        following = GithubService.find_who_i_follow(ENV['GITHUB_KEY'], "wratterman")

        # expect(following.count).to eq(4) <- As of 8/24/17. Will fail next time I follow someone
        expect(following.first["login"]).to eq("katiekeel")
        expect(following.last["login"]).to eq("JF-Lalonde")
      end
    end

    it "finds who is following current user" do
      VCR.use_cassette("services/find_followers") do
        follower = GithubService.find_followers(ENV['GITHUB_KEY'], "wratterman")

        expect(follower.last["login"]).to eq("emcooper")
      end
    end

    it "finds who is following current user" do
      VCR.use_cassette("services/find_followers") do
        followers = GithubService.find_followers(ENV['GITHUB_KEY'], "wratterman")

        # expect(followers.count).to eq(1) <- As of 8/24/17. Will fail next time I follow someone
        expect(followers.class).to eq(Array)
        expect(followers.last["login"]).to eq("emcooper")
      end
    end

    it "finds all of current user's repos" do
      VCR.use_cassette("services/find_repos") do
        repos = GithubService.find_repos(ENV['GITHUB_KEY'], "wratterman")

        # expect(repos.count).to eq(1) <- As of 8/24/17. Will fail next time I follow someone
        expect(repos.class).to eq(Array)

        names = repos.map do |repo|
          repo["name"]
        end

        expect(names).to include("Apicurious")
        expect(names).to include("storedom")
      end
    end
  end
end
