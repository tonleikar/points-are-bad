class PagesController < ApplicationController
  def index
    @matches = FootballData.fetch_games(matchday: 35)
  end
end
