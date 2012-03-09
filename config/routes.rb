Spree::Core::Engine.routes.append do

  namespace :admin do
    resources :redirects
  end
  
end
