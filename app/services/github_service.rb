class GithubService

  def initialize(token)
    @token = token
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.authorization :Token, @token
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.find_account(token)
    new(token).find_my_account
  end

  def find_my_account
    get_url("/users?access_token=#{@token}")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_name: true)
  end
end
