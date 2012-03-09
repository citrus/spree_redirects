require "test_helper"

class Spree::Admin::RedirectsTest < ActiveSupport::IntegrationCase
  
  def setup
    Spree::Redirect.destroy_all
    @redirect = Spree::Redirect.create(:old_url => "shop-online.html", :new_url => "products")
  end
    
  should "redirect with simple url" do
    visit @redirect.old_url
    assert_equal @redirect.new_url, current_path
  end
    
  should "redirect with a query string" do
    assert @redirect.update_attributes(:old_url => "shop?online=true&something=nothing")
    visit @redirect.old_url
    assert_equal @redirect.new_url, current_path
  end
    
end
