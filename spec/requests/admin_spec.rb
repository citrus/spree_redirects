require "spec_helper"

describe 'admin redirects' do
  stub_authorization!

  before do
    Spree::Redirect.destroy_all
    @labels = %(Old URL, New URL).split(', ')
    @values = %(booboo, woohoo).split(', ')        
  end
  
  it "have a link to redirects from config page" do
    visit spree.edit_admin_general_settings_path
    expect(has_link?("Manage Redirects")).to be_true
  end
  
  it "have a link to new redirect",js:true do
    visit spree.admin_redirects_path

    btn = find("#new_redirect_link").native
    assert_match /#{spree.new_admin_redirect_path}$/, btn.attribute('href')
    assert_equal "New Redirect", btn.text
  end
  
  it "get new redirect" do  
    visit spree.new_admin_redirect_path

    expect(has_content?("New Redirect")).to be_true
    within "#new_redirect" do
      @labels.each do |f|
        expect(has_field?(f)).to be_true
      end
    end
  end
    
  it "validate redirect" do
    visit spree.new_admin_redirect_path
    click_button "Create"

    within "#errorExplanation" do
      assert has_content?("3 errors prohibited this record from being saved:")
      assert has_content?("Old url can't be blank")
      assert has_content?("New url can't be blank")
      assert has_content?("The old URL may not be the same as the new URL."      )
    end
  end
  
  it "create a redirect" do
    visit spree.admin_redirects_path
    click_link "New Redirect"
    within "#new_redirect" do
      @labels.each_with_index do |label, index|
        fill_in label, :with => @values[index]      
      end
    end
    click_button "Create"

    within(".flash.notice") do
      assert has_content?("Redirect has been successfully created!")
    end
  end  
  
  context "an existing redirect" do    
    before do
      @redirect = Spree::Redirect.create(:old_url => "booboo", :new_url => "woohoo")
    end
    
    it "update redirect, user and addresses" do
      visit spree.edit_admin_redirect_path(@redirect)
      within "#edit_redirect_#{@redirect.id}" do
        @labels.each_with_index do |label, index|
          fill_in label, :with => @values[index].reverse      
        end
      end
      click_button "Update"

      assert_equal spree.admin_redirects_path, current_path
      within(".flash.notice") do
        assert has_content("Redirect has been successfully updated!")
      end

      within("tr#redirect_#{@redirect.id} td:first-child") do
        assert has_content?("/ooboob")
      end

      within("tr#redirect_#{@redirect.id} td:nth-child(2)") do
        assert has_content?("/oohoow")
      end
    end
    
  end
  
end
