require 'rails_helper'
require 'database_cleaner'

describe 'Visit the home page', type: :feature do
  let!(:game) { FactoryGirl.create(:game, name: 'Full game') }

  describe 'If there is no open game' do
    it 'Should not see the open game section' do
      visit root_path

      expect(page).to have_no_content 'All open games'
    end
  end

  describe 'If there are open games', :open_game do
    it 'Should show a list of open games' do
      # create a game that has only one player (player1)
      FactoryGirl.create(:game, name: 'First open game', player_2: nil)
      # create a game that has only one player (player2)
      FactoryGirl.create(:game, name: 'Second open game', player_1: nil)

      visit root_path

      expect(page).to have_content 'Available Games'
      expect(page).to have_content 'First open game'
      expect(page).to have_content 'Second open game'
    end
  end
end
