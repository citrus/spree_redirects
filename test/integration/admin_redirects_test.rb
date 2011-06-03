require_relative '../test_helper'

class AdminRedirectsTest < ActiveSupport::IntegrationCase
  
  setup do
    Redirect.destroy_all
    @labels = %(Old URL, New URL).split(', ')
    @values = %(booboo, woohoo).split(', ')        
  end
  
  should "have a link to new redirect" do
    visit admin_redirects_path
    btn = find(".actions a.button").native
    assert_match /#{new_admin_redirect_path}$/, btn.attribute('href')
    assert_equal "New Redirect", btn.text
  end
  
  should "get new redirect" do  
    visit new_admin_redirect_path
    assert has_content?("New Redirect")
    within "#new_redirect" do
      @labels.each do |f|
        assert has_field?(f)
      end
    end
  end
    
  should "validate redirect" do
    visit new_admin_redirect_path
    click_button "Create"
    within "#errorExplanation" do
      assert_seen "3 errors prohibited this record from being saved:"
      assert_seen "Old url can't be blank"
      assert_seen "New url can't be blank"
      assert_seen "The old URL may not be the same as the new URL."      
    end
  end
  
  should "create a redirect" do
    visit new_admin_redirect_path
    within "#new_redirect" do
      @labels.each_with_index do |label, index|
      	fill_in label, :with => @values[index]      
      end
    end
    click_button "Create"
    assert_flash(:notice, "Redirect has been successfully created!")
  end  
  
  context "an existing redirect" do    
    setup do
      @redirect = Redirect.create(:old_url => "booboo", :new_url => "woohoo")
    end
    
    should "update redirect, user and addresses" do
      visit edit_admin_redirect_path(@redirect)
      
      within "#edit_redirect_#{@redirect.id}" do
        @labels.each_with_index do |label, index|
        	fill_in label, :with => @values[index].reverse      
        end
      end
      click_button "Update"
      assert_equal admin_redirects_path, current_path      
      assert_flash(:notice, "Redirect has been successfully updated!")
      assert_seen "/ooboob", :within => "tr#redirect_#{@redirect.id} td:first-child"
      assert_seen "/oohoow", :within => "tr#redirect_#{@redirect.id} td:nth-child(2)"
    end
    
  end
  
end
