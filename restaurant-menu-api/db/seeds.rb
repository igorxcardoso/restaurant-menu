ActiveRecord::Base.transaction do
	restaurants = [
		{
			name: 'Pasta Place',
			menus: [
				{
					name: 'Lunch',
					items: [
						{ name: 'Spaghetti Marinara', price: 12.5 },
						{ name: 'Penne Alfredo', price: 13.0 },
						{ name: 'Bruschetta', price: 6.0 }
					]
				},
				{
					name: 'Dinner',
					items: [
						{ name: 'Lasagna', price: 15.0 },
						{ name: 'Tiramisu', price: 7.0 }
					]
				}
			]
		},
		{
			name: 'Sushi Corner',
			menus: [
				{
					name: 'All Day',
					items: [
						{ name: 'California Roll', price: 8.5 },
						{ name: 'Salmon Nigiri', price: 3.5 },
						{ name: 'Miso Soup', price: 2.5 }
					]
				}
			]
		},
		{
			name: 'Burger Barn',
			menus: [
				{
					name: 'Main',
					items: [
						{ name: 'Classic Burger', price: 10.0 },
						{ name: 'Cheese Fries', price: 4.5 }
					]
				}
			]
		}
	]

	restaurants.each do |r|
		restaurant = Restaurant.find_or_create_by!(name: r[:name])

		r[:menus].each do |m|
			menu = restaurant.menus.find_or_create_by!(name: m[:name])

			m[:items].each do |it|
				item = MenuItem.find_or_create_by!(name: it[:name]) do |mi|
					mi.price = it[:price]
				end

				# Ensure price is in sync if seed changed
				if item.price != it[:price]
					item.update!(price: it[:price])
				end

				# Associate item with menu unless already associated
				unless menu.menu_items.exists?(item.id)
					menu.menu_items << item
				end
			end
		end
	end

	puts "Seeded #{Restaurant.count} restaurants, #{Menu.count} menus, #{MenuItem.count} menu items"
end

# You can run this with: bin/rails db:seed
