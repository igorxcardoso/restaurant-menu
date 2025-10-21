Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :restaurants, only: [:index, :show]
      resources :menus, only: [:index, :show] do
        resources :menu_items, only: [:index]
      end

      resources :imports, only: [:create]
    end
  end
end
