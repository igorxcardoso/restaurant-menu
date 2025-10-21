### Rails application creation
rails new restaurant-menu-api --api --database=postgresql --skip-git

### Model Generation
rails g model restaurant name:string
rails g model menu restaurant:references name:string
rails g model menu_item name:string price:float
rails g migration create_join_table_menus_menu_items menus menu_items

