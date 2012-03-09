require "pp"
module SpreeRedirects
  class RedirectMiddleware
    
    def initialize(app)
      @app = app
    end
   
    def call(env)
      
      puts "OMGOMGOMGOMGOMGOMGOMGOMOM"
      puts [ env["PATH_INFO"], env["QUERY_STRING"] ].join("?").sub(/[\?\s]*$/, "").strip
      puts Rails.application.config.middleware.inspect
      pp env
      # execute the request using our Rails app
      status, headers, body = @app.call(env)
      
      puts "STATUS: #{status}"
      
      if status == 404 && url = find_redirect([ env["PATH_INFO"], env["QUERY_STRING"] ].join("?").sub(/[\?\s]*$/, "").strip)
        # Issue a "Moved permanently" response with the redirect location
        [ 301, { "Location" => url }, [ "Redirecting..." ] ]
      else
        # Not a 404 or no redirect found, just send the response as is
        [ status, headers, body ]
      end
    end
   
    def find_redirect(url)
      puts "FINDING #{url}"
      puts Spree::Redirect.find_by_old_url(url)
      redirect = Spree::Redirect.find_by_old_url(url)
      return if redirect.nil?
      redirect.new_url
    end
    
  end
end 
