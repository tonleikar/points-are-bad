class PagesController < ApplicationController
  def index
    @matches = FootballData.fetch_scores(matchday: 35)
  end
end
