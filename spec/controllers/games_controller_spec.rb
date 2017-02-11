require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#create action' do
    it 'should create a new game in the database' do
      @game = FactoryGirl.create(:game)

      post :create, params: { game: { name: 'test game' } }
      expect(response).to redirect_to root_path

      @game = Game.last
      expect(game.name).to eq 'test game'
    end

    it 'should deal with errors correctly' do
      post :create, params: { game: { name: '' } }
      expect(Game.count).to eq 0
    end
  end
end
