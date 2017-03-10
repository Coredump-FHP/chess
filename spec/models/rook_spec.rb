require 'rails_helper'

RSpec.describe Rook, type: :model do
  def create_rook(x, y)
    FactoryGirl.create(:rook, x_coordinate: x, y_coordinate: y)
  end

  describe '#valid_move?' do
    it 'should be able to move horizontally to the rt' do
      rook = create_rook(0, 0)
      expect(rook.valid_move?(5, 0)).to eq true
    end

    it 'should be able to move horizontally to the lt' do
      rook = create_rook(5, 0)
      expect(rook.valid_move?(0, 0)).to eq true
    end

    it 'should be able to move vertically to the top' do
      rook = create_rook(0, 0)
      expect(rook.valid_move?(0, 7)).to eq true
    end

    it 'should be able to move vertically to the top' do
      rook = create_rook(0, 7)
      expect(rook.valid_move?(0, 0)).to eq true
    end

    it 'should return false when moving diagonally' do
      rook = create_rook(0, 0)
      expect(rook.valid_move?(1, 1)).to eq false
    end

    it 'should return false for other steps' do
      rook = create_rook(4, 3)
      expect(rook.valid_move?(5, 7)).to eq false
    end
  end
end
