class Redirect < ActiveRecord::Base

  validates :old_url, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :new_url, :presence => true
  validate :validate_urls

  before_validation :normalize_urls
  
  def normalize_urls
    [ :old_url, :new_url ].map{|attribute| write_attribute attribute, normalize_url(send attribute) } 
  end
  
  def validate_urls
    errors.add(:base, I18n.t('duplicate_url_error')) if old_url == new_url    
  end

  private

    def normalize_url(url)
      return url if url.blank?
      url.to_s.downcase.sub!(/^[\/\s]*/, '/').strip
    end
   
end
