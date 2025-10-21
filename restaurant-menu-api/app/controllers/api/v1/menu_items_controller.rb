class Api::V1::MenuItemsController < ApplicationController

  # GET /api/v1/menus/:menu_id/menu_items
  def index
    @menu_items = Menu.find(params[:menu_id]).menu_items
    render json: @menu_items.map{|m| MenuItemSerializer.new(m).as_json}
  end
end
