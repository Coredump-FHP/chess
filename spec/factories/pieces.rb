FactoryGirl.define do
  factory :piece do
  	color 'black or white'
  	x_coordinates 'test x_coordinates'
  	y_coordinates 'test y_xcoordinates'
  	type 'type'
  	captured 'false by default'
  end
end