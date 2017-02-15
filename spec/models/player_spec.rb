require 'rails_helper'

RSpec.describe Player, type: :model do
	it "has a valid factory" do
		FactoryGirl.build(:player)
	end
end
