class MenuSerializer
  def initialize(menu)
    @menu = menu
  end

  def as_json(*)
    {
      name: @menu.name,
      menu_items: @menu.menu_items.map do |menu_item|
        ::MenuItemSerializer.new(menu_item).as_json
      end
    }
  end
end
