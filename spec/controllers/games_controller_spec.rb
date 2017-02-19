require 'rails_helper'
require 'pry'

RSpec.describe GamesController, type: :controller do
  describe 'games#new action' do
    it 'should login players and create a new game form' do
      player = FactoryGirl.create(:player)
      sign_in player

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    it 'should create a new game in the database' do
      player = FactoryGirl.create(:player)
      sign_in player

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
