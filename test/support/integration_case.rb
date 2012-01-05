# Define a bare test case to use with Capybara

class ActiveSupport::IntegrationCase < ActiveSupport::TestCase

  include Capybara::DSL
  include Rails.application.routes.url_helpers
  
  # Extreme hax! wtf is this for anyways.. and why is it erroring?
  def testmail_admin_mail_method_url(*args)
    "#wtf"  
  end
  alias :testmail_admin_mail_method_path :testmail_admin_mail_method_url
    
  self.use_transactional_fixtures = false
  
  def assert_seen(text, opts={})
    if opts[:within]
      within(opts[:within]) do
        assert has_content?(text)
      end
    else
      assert has_content?(text)
    end
  end
  
  def assert_flash(key, text)
    within(".flash.#{key}") do
      assert_seen(text)
    end
  end

end
