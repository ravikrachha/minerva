Rails.application.routes.draw do
	resources :journels, only: [:create, :new, :index, :show] do
		member do
			get 'search_entries'
			get 'graph_data'
		end
		collection do
			get 'search'
		end
		resources :journel_entries, only: [:new, :create, :show, :edit, :update]
	end
	root 'journels#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
