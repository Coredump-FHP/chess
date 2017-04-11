class StaticPagesController < ApplicationController
  def home
    @open_games = Game.available.order('created_at DESC')
  end
end
