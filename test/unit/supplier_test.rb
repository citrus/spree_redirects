require_relative '../test_helper'

class RedirectTest < ActiveSupport::TestCase
  
  should validate_presence_of(:old_url)
  should validate_presence_of(:new_url)
  
end