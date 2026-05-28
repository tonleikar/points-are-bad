class LeaguesController < ApplicationController
  def index
    # @leagues = current_user.leagues
    # TODO add this after creating the leagues joining table
  end

  def show
    @league = League.find(params[:id])
  end

  def new
    @league = League.new
  end

  def create
    @league = current_user.created_leagues.build(league_params)

    if @league.save
      redirect_to @league, notice: "League was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end
end
