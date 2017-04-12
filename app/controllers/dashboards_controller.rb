class DashboardsController < ApplicationController
  before_action :authenticate_player!

  def games_dashboard
    @open_games = Game.available.order('created_at DESC')
  end
end
