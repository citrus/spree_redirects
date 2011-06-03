require_relative '../test_helper'

class AdminRedirectsTest < ActiveSupport::IntegrationCase
  
  def setup
    Redirect.destroy_all
    @redirect = Redirect.create(:old_url => "shop-online.html", :new_url => "products")
  end
  
  should "redirect with simple url" do
    visit @redirect.old_url
    assert_equal current_path, @redirect.new_url
  end
    
  should "redirect with a query string" do
    assert @redirect.update_attributes(:old_url => "shop?online=true&something=nothing")
    visit @redirect.old_url
    assert_equal current_path, @redirect.new_url
  end
    
end
