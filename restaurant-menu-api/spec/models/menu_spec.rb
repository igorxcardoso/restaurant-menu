require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "has a valid factory" do
    expect(build(:menu)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:menu, name: nil)).to be_invalid
  end

  it "belongs to a restaurant" do
    menu = create(:menu)
    expect(menu.restaurant).to be_present
  end

  it "can have menu_items through HABTM" do
    menu = create(:menu)
    item = create(:menu_item)
    menu.menu_items << item
    expect(menu.menu_items).to include(item)
  end
end
