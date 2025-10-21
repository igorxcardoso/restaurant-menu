class MenuItemSerializer
  def initialize(menu_item)
    @menu_item = menu_item
  end

  def as_json(*)
    { 
      name: @menu_item.name,
      price: @menu_item.price 
    }
  end
end
