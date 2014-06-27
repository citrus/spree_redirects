module SpreeRedirects
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name "spree_redirects"

    config.autoload_paths += %W(#{config.root}/lib)
    
    initializer "redirect middleware" do |app|
      app.middleware.insert_after ::ActionDispatch::DebugExceptions, ::SpreeRedirects::RedirectMiddleware
    end

    config.to_prepare {}
  end
end
