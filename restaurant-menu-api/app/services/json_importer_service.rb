class JsonImporterService

  def initialize(payload)
    @payload = payload
  end

  def call
    process_restaurants
    true
  rescue StandardError => e
    puts "Import failed: #{e.message}"
  end

  private

  def process_restaurants
    Array(@payload['restaurants']).each do |r|
      restaurant = Restaurant.find_or_create_by!(name: r['name'])
      process_menus(restaurant, r['menus'])
    end
  end

  def process_menus(restaurant, menus)
    Array(menus).each do |m|
      menu = restaurant.menus.find_or_create_by!(name: m['name'])
      items_key = m.key?('menu_items') ? 'menu_items' : (m.key?('dishes') ? 'dishes' : nil)
      process_menu_items(menu, Array(m[items_key])) if items_key
    end
  end

  def process_menu_items(menu, items)
    items.each do |item|
      name = item['name']
      price = item['price']
      begin
        menu_item = MenuItem.find_or_initialize_by(name: name)
        menu_item.price = price
        menu_item.save!
        menu.menu_items << menu_item unless menu.menu_items.exists?(menu_item.id)
      rescue ActiveRecord::RecordInvalid => e
        puts "Error importing menu item '#{name}': #{e.message}"
      end
    end
  end
end
