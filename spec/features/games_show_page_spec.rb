require 'rails_helper'

describe 'Visit the games show page', type: :feature do
  it 'displays the users gravatar via their email address' do
    game = FactoryGirl.create(:game)

    visit game_path(game)
    within('.container') do
      expect(page).to have_css('.gravatars')
    end
  end
end

