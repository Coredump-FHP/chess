require 'rails_helper'

RSpec.describe Rook, type: :model do 
  def create_rook(x,y)
    FactoryGirl.create(:rook, x_coordinate: x, y_coordinate: y)
  end 

  describe '#valid_move?' do 
    it "can move horizontally" do
    #horizontal moves mean that only the x_coordinate moves
      rook = create_rook(0,0)
      expect(rook.valid_move?(5,0)).to eq true
    end

    it "can move vertically" do
      #vertical moves mean that only the y_coordinate moves
      rook = create_rook(0,0)
      expect(rook.valid_move?(0,5)).to eq true
    end

    it "returns false if moves diagonally" do
      rook = create_rook(0,0)
      expect(rook.valid_move?(1,1)).to eq false
    end

  end

end 


