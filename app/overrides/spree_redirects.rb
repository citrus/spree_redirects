Deface::Override.new(:virtual_path  => "spree/admin/shared/_configuration_menu",
                     :name          => "spree_redirect_config_opt",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text          => "<%= configurations_sidebar_menu_item t(:redirects), admin_redirects_path %>",
                     :disabled      => false)
