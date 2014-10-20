class Spree::Redirect < ActiveRecord::Base

  attr_accessible :old_url, :new_url, :status_code

  validates :old_url, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :new_url, :presence => true
  validate :validate_urls

  before_validation :normalize_urls

  class << self

    def find_by_old_url!(url)
      super normalize_url(url)
    end

    def find_by_old_url(url)
      super normalize_url(url)
    end

    def normalize_url(url)
      return url if url.blank? or url == '/'
      url.strip.sub(/^[\/\s]*/, "/").sub(/\/+$/, "")
    end

  end

  def status_code
    read_attribute(:status_code) || 301
  end

  def status_code_presentation
    case status_code
    when 302
      "Temporary (302)"
    else
      "Permanent (301)"
    end
  end

  def normalize_urls
    [ :old_url, :new_url ].map{|attribute| write_attribute attribute, self.class.normalize_url(send attribute) }
  end

  def validate_urls
    errors.add(:base, I18n.t('duplicate_url_error')) if old_url == new_url
  end

end
