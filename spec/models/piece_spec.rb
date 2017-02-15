require 'rails_helper'

RSpec.describe Piece, type: :model do
  it 'has a valid factory' do
   FactoryGirl.build(:piece)
  end
end
