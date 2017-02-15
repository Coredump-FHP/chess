require 'rails_helper'
# Factory needs to be registered for player
RSpec.describe Player, type: :model do
  it 'has a valid factory' do
    FactoryGirl.build(:player)
  end
end
