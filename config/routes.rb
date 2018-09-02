Rails.application.routes.draw do
resources :searches
resources :contacts do
  get :autocomplete_number_name, :on => :collection
end
  root to: 'searches#index'
  post '/change_task_status'=>'projects#change_task_status'
  devise_for :users
  get '/search' => 'searches#find_number'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
