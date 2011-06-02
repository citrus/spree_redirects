class Redirect < ActiveRecord::Base

  validates :old_url, :presence => true, :uniqueness => { :case_sensitive => false }  
  validates :new_url, :presence => true

end
