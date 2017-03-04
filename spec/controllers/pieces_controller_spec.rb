require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'pieces#show action' do
    it 'should successfuly show the hightlighted piece' do
    end
  end

  describe 'pieces#update action' do
    it 'updates the coordinates of the piece' do
      piece = create(:piece)

      patch :update, params: { id: piece.id, x_coordinate: 4, y_coordinate: 5 }
      piece.reload

      expect(response).to have_http_status :ok
      expect(piece.x_coordinate).to eq 4
      expect(piece.y_coordinate).to eq 5
    end
  end
end
