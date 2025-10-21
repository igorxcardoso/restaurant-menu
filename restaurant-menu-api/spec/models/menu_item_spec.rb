require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it "has a valid factory" do
    expect(build(:menu_item)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:menu_item, name: nil)).to be_invalid
  end

  it "is invalid without a price" do
    expect(build(:menu_item, price: nil)).to be_invalid
  end

  it "validates price is non-negative" do
    expect(build(:menu_item, price: -1)).to be_invalid
  end

  it "validates uniqueness of name" do
    create(:menu_item, name: "Unique Item")
    expect(build(:menu_item, name: "Unique Item")).to be_invalid
  end
end
