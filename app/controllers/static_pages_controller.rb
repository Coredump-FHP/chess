class StaticPagesController < ApplicationController
  def home
    @open_games = Game.available
  end
end
