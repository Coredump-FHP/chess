require 'rails_helper'

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
      expect(response).to redirect_to games_dashboard_path

      @game = Game.last
      expect(@game.name).to eq 'test game'
    end

    it 'should set player_1_id when creating a new game' do
      player = FactoryGirl.create(:player)
      sign_in player

      post :create, params: { game: { name: 'test game' } }
      @game = Game.last
      expect(@game.name).to eq 'test game'
      expect(@game.player_1_id).to eq player.id
    end

    it 'sets the first turn of the game to the player that created the game' do
      player1 = FactoryGirl.create(:player)
      sign_in player1
      @game = FactoryGirl.create(:game, player_1: player1)
      @game.update_attributes!(turn: player1.id)
      expect(@game.reload.turn).to eq player1.id
    end

    it 'should deal with errors correctly' do
      post :create, params: { game: { name: '' } }
      expect(Game.count).to eq 0
    end
  end

  describe 'games#update action' do
    it 'should set player_2_id when a second player joins a created game' do
      player1 = FactoryGirl.create(:player)
      sign_in player1

      post :create, params: { game: { name: 'test game' } }
      @game = Game.last
      sign_out player1
      player2 = FactoryGirl.create(:player)
      sign_in player2

      patch :update, params: { id: @game.id }
      @game.reload
      expect(@game.name).to eq 'test game'
      expect(@game.player_2_id).to eq player2.id
    end
  end
  describe 'games#forfeit action' do
    it 'it should trigger forfeit_game method in model' do
      player1 = FactoryGirl.create(:player)
      sign_in player1

      post :create, params: { game: { name: 'test game' } }
      @game = Game.last
      sign_out player1
      player2 = FactoryGirl.create(:player)
      sign_in player2

      patch :forfeit, params: { winning_player_id: player1.id, game_id: @game.id }
      @game.reload
      expect(@game.winning_player_id).to eq player1.id
    end
  end
end
