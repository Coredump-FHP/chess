require 'rails_helper'
require 'pry'

RSpec.describe GamesController, type: :controller do
  describe 'games#new action' do
    it 'should initialize the pieces on the board' do
      player_1 = FactoryGirl.create(:player_1)
      player_2 = FactoryGirl.create(:player_2)
      sign_in player_1
      sign_in player_2

      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece)
    end
  end

  describe 'games#create action' do
    it 'should create a new game in the database' do
      post :create, params: { game: { name: 'test game' } }
      expect(response).to redirect_to root_path

      @game = Game.last

      expect(@game.name).to eq 'test game'
    end

    it 'should deal with errors correctly' do
      post :create, params: { game: { name: '' } }
      expect(Game.count).to eq 0
    end
  end
end
