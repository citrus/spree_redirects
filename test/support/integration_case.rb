# Define a bare test case to use with Capybara

class ActiveSupport::IntegrationCase < ActionController::TestCase

  include Capybara::DSL
  
  def spree
    Spree::Core::Engine.routes.url_helpers
  end
  
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
