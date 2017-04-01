require 'rails_helper'

describe 'Visit the game page', type: :feature do
  context 'when drag and drop a chess piece to an empty square' do
    it 'updates the coordinates of the piece', js: true do
      # piece = FactoryGirl.create(:piece)
      # game = piece.game

      # For testcase to pass, it would require quite a few drivers
      # Need to come up with a better way to get drag and drop to work

      # The next items need Selenium

      # visit game_path(game)

      # piece_to_drag = page.find("#piece-#{piece.id}")
      # target = page.find('td[data-x="0"][data-y="4"]')

      # piece_to_drag.drag_to(target)

      # sleep 4

      # piece.reload

      # expect(piece.x_coordinate).to eq 0
      # expect(piece.y_coordinate).to eq 4
    end
  end
end
