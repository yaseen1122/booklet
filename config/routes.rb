Rails.application.routes.draw do
	root to: 'bookleets#index'
  
  resources :bookleets do
  	resources :tbcs
  end
  get '/generate_booklet', to: 'bookleets#generate_booklet', as: 'generate_booklet'
  get '/download_booklet', to: "bookleets#download_booklet", as: 'downloade_booklet'
  post '/upload_booklets',  to: 'bookleets#upload_booklets' , as: 'upload_booklets'
  get '/delete_booklets',  to: 'bookleets#delete_booklets' , as: 'delete_booklets'
  get '/delete_selected_file',  to: 'bookleets#delete_selected_file' , as: 'delete_selected_file'
end
