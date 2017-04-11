require 'rails_helper'

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
      FactoryGirl.create(:game, name: 'First open game')

      visit root_path
      expect(page).to have_content 'Available Games'
    end
  end
end
