require 'rails_helper'

describe 'Visit the home page', type: :feature do
  before do |test|
    # a game that has both players
    FactoryGirl.create(:game, name: 'Full game')

    if test.metadata[:open_game]
      # a game that has only one player (player1)
      @game2 = FactoryGirl.create(:game, name: 'First open game', player_2: nil)

      # a game that has only one player (player2)
      @game3 = FactoryGirl.create(:game, name: 'Second open game', player_1: nil)
    end

    visit root_path
  end
  describe 'If there is no open game' do
    it 'Should not see the open game section' do
      expect(page).to have_no_content 'All open games'
    end
  end

  describe 'If there are open games', :open_game do
    it 'Should show a list of open games' do
      expect(page).to have_content 'All open games'
      expect(page).to have_content 'First open game'
      expect(page).to have_content 'Second open game'
      expect(page).to have_no_content 'Full game'
    end
  end
end
