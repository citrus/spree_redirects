module SpreeRedirects
  class Engine < Rails::Engine
    engine_name "spree_redirects"
    
    initializer "redirect middleware" do |app|
      app.middleware.insert_after ::ActionDispatch::DebugExceptions, ::SpreeRedirects::RedirectMiddleware
    end

    config.to_prepare {}
  end
end
