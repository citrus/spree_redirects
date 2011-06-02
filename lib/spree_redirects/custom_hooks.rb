module SpreeRedirects
  class CustomHooks < Spree::ThemeSupport::HookListener
    
    insert_after :admin_configurations_menu, 'admin/shared/redirect_config'

  end
end