require 'spec_helper'

describe 'redirect' do
  before do    
    Spree::Redirect.destroy_all
    @redirect = Spree::Redirect.new
  end
  
  # should validate_presence_of(:old_url)
  # should validate_presence_of(:new_url)
    
  it "not allow old to equal new" do
    @redirect.old_url = @redirect.new_url = "omgomg"

    expect(@redirect.valid?).to be_false
    expect(@redirect.save).to be_false
    expect(@redirect.errors.include?(:base)).to be_true
  end

  it "strip extra spaces" do
    @redirect.attributes = { :old_url => "   booboo   ", :new_url => " woohoo " }
    assert @redirect.save
    assert_equal @redirect.old_url, "/booboo"
    assert_equal @redirect.new_url, "/woohoo"
  end
  
  it "not duplicate starting slash" do
    @redirect.attributes = { :old_url => "/booboo", :new_url => "/woohoo" }
    assert @redirect.save
    assert_equal @redirect.old_url, "/booboo"
    assert_equal @redirect.new_url, "/woohoo"
  end
  
  it "remove multiple slashes" do
    @redirect.attributes = { :old_url => "//booboo", :new_url => "////////woohoo" }
    
    expect(@redirect.save).to be_true
    expect(@redirect.old_url).to eq("/booboo")
    expect(@redirect.new_url).to eq("/woohoo")
  end

  it "remove multiple slashes with spaces between" do
    @redirect.attributes = { :old_url => "/ /booboo", :new_url => "//  /  / //woohoo" }

    expect(@redirect.save).to be_true
    expect(@redirect.old_url).to eq("/booboo")
    expect(@redirect.new_url).to eq("/woohoo")
  end

  it "return nil when not found by old url" do
    assert_equal nil, Spree::Redirect.find_by_old_url("/omg/nil")
  end

  it "raise routing error when not found by old url" do
    assert_raises ActiveRecord::RecordNotFound do
      Spree::Redirect.find_by_old_url!("/omg/error")
    end
  end

  context "a url with proper attributes" do
  
    before do
      @redirect.attributes = { :old_url => "booboo", :new_url => "woohoo" }
    end
    
    it "ensure starting slash" do
      expect(@redirect.old_url).to eq("booboo")
      expect(@redirect.save).to be_true
      expect(@redirect.old_url).to eq("/booboo")
      expect(@redirect.new_url).to eq("/woohoo")
    end

    context "when saved" do
     
      before do
        assert @redirect.save
      end
      
      it "normalize url when looking up by url" do
        @redirect.should == Spree::Redirect.find_by_old_url("//booboo/")
      end
      
    end
      
  end
    
end
