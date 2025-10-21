require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "has a valid factory" do
    expect(build(:restaurant)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:restaurant, name: nil)).to be_invalid
  end

  it "validates uniqueness of name" do
    create(:restaurant, name: "Unique Name")
    expect(build(:restaurant, name: "Unique Name")).to be_invalid
  end

  it "has many menus" do
    restaurant = create(:restaurant)
    menu = create(:menu, restaurant: restaurant)
    expect(restaurant.menus).to include(menu)
  end
end
