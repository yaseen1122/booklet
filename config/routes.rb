Rails.application.routes.draw do
	root to: 'bookleets#index'
  
  resources :bookleets do
  	resources :tbcs
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
