class CreateJoinTableMenusMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_join_table :menus, :menu_items do |t|
      t.index [:menu_id, :menu_item_id]
      t.index [:menu_item_id, :menu_id]
    end
  end
end
