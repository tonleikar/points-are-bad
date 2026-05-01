require "open-uri"
require "json"

class FootballData
  BASE_URL = "https://api.football-data.org/v4"

  def self.fetch_scores(matchday: nil)
    url = URI("#{BASE_URL}/competitions/PL/matches/#{matchday ? "?matchday=#{matchday}" : ""}")

    response = URI.open(url, "X-Auth-Token" => ENV["FOOTBALL_DATA_KEY"]).read
    JSON.parse(response)[:matches]
  rescue StandardError => e
    { error: "Failed to fetch football data: #{e.message}" }
  end
end
