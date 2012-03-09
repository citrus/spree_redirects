module SpreeRedirects
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      desc "Installs required migrations for spree_redirects"
      
      def copy_migrations
        rake "spree_redirects:install:migrations"
      end

    end
  end
end
