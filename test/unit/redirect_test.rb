require "test_helper"

class RedirectTest < ActiveSupport::TestCase
  
  def setup    
    Redirect.destroy_all
    @redirect = Redirect.new
  end
  
  should "require urls to be set" do
    assert !@redirect.valid?
    assert !@redirect.save
    assert @redirect.errors.include?(:old_url)
    assert @redirect.errors.include?(:new_url)
  end
  
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

  context "a url with proper attributes" do
  
    setup do
      @redirect.attributes = { :old_url => "booboo", :new_url => "woohoo" }
    end
    
    should "ensure starting slash" do
      assert @redirect.save
      assert_equal @redirect.old_url, "/booboo"
      assert_equal @redirect.new_url, "/woohoo"
    end
      
  end
  
end