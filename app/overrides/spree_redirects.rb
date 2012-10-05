Deface::Override.new(:virtual_path  => "spree/admin/configurations/index",
                     :name          => "spree_redirect_config_opt",
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :partial       => "spree/admin/shared/redirect_config",
                     :disabled      => false)

Deface::Override.new(:virtual_path  => "spree/admin/shared/_configuration_menu",
                     :name          => "spree_redirect_config_opt_sidebar",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text          => "<%= configurations_sidebar_menu_item t(:redirects), admin_redirects_path %>",
                     :disabled      => false)
