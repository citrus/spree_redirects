require 'spree_core'
require 'spree_redirects/custom_hooks'
require 'spree_redirects/redirect_middleware'

module SpreeRedirects

  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)        

    initializer "redirect middleware" do |app|
      app.middleware.insert_before ::Rack::Lock, ::SpreeRedirects::RedirectMiddleware
    end
    
  end

end
