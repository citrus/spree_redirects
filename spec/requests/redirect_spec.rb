require "spec_helper"

describe 'redirect test' do
  
  before do
    Spree::Redirect.destroy_all
    @redirect = Spree::Redirect.create(:old_url => "shop-online.html", :new_url => "products")
  end
    
  it "redirect with simple url" do
    visit @redirect.old_url
    @redirect.new_url.should == current_path
  end
    
  it "redirect with a query string" do
    expect(@redirect.update_attributes(:old_url => "shop?online=true&something=nothing")).to be_true

    visit @redirect.old_url
    @redirect.new_url.should == current_path
  end
    
end
