require 'rails_helper'

RSpec.describe JsonImporterService, type: :service do
  let(:fixture_path) { Rails.root.join('spec/fixtures/files/restaurant_data.json') }
  let(:payload) { JSON.parse(File.read(fixture_path)) }

  it 'imports restaurants, menus and menu_items and returns logs' do
    result = JsonImporterService.new(payload).call
    expect(result.success).to be true
    expect(result.logs).to be_an(Array)

    expect(Restaurant.count).to eq(2)
    expect(Menu.count).to be >= 4
    expect(MenuItem.count).to be >= 5
  end

  it 'handles duplicate menu_item names gracefully (uniqueness enforced)' do
    # First import
    JsonImporterService.new(payload).call
    # Second import should not create duplicate MenuItem names
    result2 = JsonImporterService.new(payload).call
    expect(result2.success).to be true
    # MenuItem count should remain unchanged after re-import since names are unique
    expect(MenuItem.where(name: 'Burger').count).to eq(1)
  end
end
