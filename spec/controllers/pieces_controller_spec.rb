require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  render_views
  describe 'pieces#show action' do
    it 'shows the selected piece on the pieces/show page and highlights it' do
      piece = FactoryGirl.create(:piece)
      get :show, params: { id: piece.id }

      expect(response).to be_ok
      expect(response.body).to match(/class="highlight"/)
    end
  end

  describe 'pieces#update action' do
    it 'updates the piece with the new destination coordinates' do
      piece = FactoryGirl.create(:piece)

      patch :update, params: { id: piece.id, piece: { x_coordinate: 5, y_coordinate: 8 } }
      expect(response).to have_http_status(:success)
      piece.reload
      expect(piece.x_coordinate).to eq 5
      expect(piece.y_coordinate).to eq 8
    end

    it 'changes turns based on who moved the last piece' do
      player1 = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)
      sign_in player1
      sign_in player2

      @game = FactoryGirl.create(:game, player_1: player1, player_2: player2)
      @game.update_attributes!(turn: player1.id)
      piece = FactoryGirl.create(:piece, game: @game)

      patch :update, params: { id: piece.id, piece: { x_coordinate: 5, y_coordinate: 8 } }

      expect(response).to have_http_status(:success)
      piece.reload
      expect(piece.x_coordinate).to eq 5
      expect(piece.y_coordinate).to eq 8
      expect(@game.reload.turn).to eq player2.id
    end
  end
end
