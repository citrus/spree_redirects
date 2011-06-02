Rails.application.routes.draw do

  namespace :admin do
    resources :redirects
  end
  
end
