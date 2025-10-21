Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :menus, only: [:index, :show] do
        resources :menu_items, only: [:index]
      end
    end
  end
end
