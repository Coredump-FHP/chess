require 'rails_helper'
require 'spec_helper'

RSpec.describe DashboardsController, type: :controller do
  describe 'Visit the games_dashboard_path page', type: :feature do
    let!(:game) { FactoryGirl.create(:game, name: 'Full game') }

    describe 'If there is no open game' do
      it 'Should not see the open game section' do
        player = FactoryGirl.create(:player)
        sign_in player
        visit games_dashboard_path

        expect(page).to have_no_content 'All open games'
      end
    end
  end
end
