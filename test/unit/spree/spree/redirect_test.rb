require "test_helper"

class Spree::RedirectTest < ActiveSupport::TestCase
  
  def setup    
    Spree::Redirect.destroy_all
    @redirect = Spree::Redirect.new
  end
  
  should validate_presence_of(:old_url)
  should validate_presence_of(:new_url)
    
  should "not allow old to equal new" do
    @redirect.old_url = @redirect.new_url = "omgomg"
    assert !@redirect.valid?
    assert !@redirect.save
    assert @redirect.errors.include?(:base)
  end

  should "strip extra spaces" do
    @redirect.attributes = { :old_url => "   booboo   ", :new_url => " woohoo " }
    assert @redirect.save
    assert_equal @redirect.old_url, "/booboo"
    assert_equal @redirect.new_url, "/woohoo"
  end
  
  should "not duplicate starting slash" do
    @redirect.attributes = { :old_url => "/booboo", :new_url => "/woohoo" }
    assert @redirect.save
    assert_equal @redirect.old_url, "/booboo"
    assert_equal @redirect.new_url, "/woohoo"
  end
  
  should "remove multiple slashes" do
    @redirect.attributes = { :old_url => "//booboo", :new_url => "////////woohoo" }
    assert @redirect.save
    assert_equal @redirect.old_url, "/booboo"
    assert_equal @redirect.new_url, "/woohoo"
  end

  should "remove multiple slashes with spaces between" do
    @redirect.attributes = { :old_url => "/ /booboo", :new_url => "//  /  / //woohoo" }
    assert @redirect.save
    assert_equal @redirect.old_url, "/booboo"
    assert_equal @redirect.new_url, "/woohoo"
  end

  should "return nil when not found by old url" do
    assert_equal nil, Spree::Redirect.find_by_old_url("/omg/nil")
  end

  should "raise routing error when not found by old url" do
    assert_raises ActiveRecord::RecordNotFound do
      Spree::Redirect.find_by_old_url!("/omg/error")
    end
  end

  context "a url with proper attributes" do
  
    setup do
      @redirect.attributes = { :old_url => "booboo", :new_url => "woohoo" }
    end
    
    should "ensure starting slash" do
      assert_equal @redirect.old_url, "booboo"
      assert @redirect.save
      assert_equal @redirect.old_url, "/booboo"
      assert_equal @redirect.new_url, "/woohoo"
    end

    context "when saved" do
     
      setup do
        assert @redirect.save
      end
      
      should "normalize url when looking up by url" do
        assert_equal @redirect, Spree::Redirect.find_by_old_url("//booboo/")
      end
      
    end
      
  end
    
end
