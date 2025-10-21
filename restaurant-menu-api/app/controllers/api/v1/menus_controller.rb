class Api::V1::MenusController < ApplicationController

  # GET /api/v1/menus
  def index
    @menus = Menu.all
    render json: @menus.map{|m| MenuSerializer.new(m).as_json}
  end

  # GET /api/v1/menus/:id
  def show
    @menu = Menu.find(params[:id])
    render json: MenuSerializer.new(@menu).as_json
  end
end
