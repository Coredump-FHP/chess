require 'rails_helper'
require 'pry'

RSpec.describe GamesController, type: :controller do
  describe 'games#new action' do
    it 'should login players' do
      player = FactoryGirl.build(:player)
      sign_in player
    end

    it 'should initialize pieces on the board' do
      @game = FactoryGirl.build(:game)
      # gets all the pieces
      # puts game.pieces.all
      @piece = FactoryGirl.build(:piece)
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
