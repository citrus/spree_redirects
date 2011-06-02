require 'spree_core'
require 'spree_redirects/custom_hooks'
require 'spree_redirects/redirect_middleware'

module SpreeRedirects

  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)        
    config.app_middleware.use "SpreeRedirects::RedirectMiddleware"

        
    #def self.activate
    #  
    #  Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator.rb")) do |c|
    #    Rails.env.production? ? require(c) : load(c)
    #  end
    #  
    #end
    #
    #config.to_prepare &method(:activate).to_proc
    
  end

end
