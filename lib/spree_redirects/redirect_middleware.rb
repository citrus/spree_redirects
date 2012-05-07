module SpreeRedirects
  class RedirectMiddleware
    
    def initialize(app)
      @app = app
    end
   
    def call(env)
      status, headers, body = @app.call(env)
      path = [ env["PATH_INFO"], env["QUERY_STRING"] ].join("?").sub(/[\/\?\s]*$/, "").strip
      if status == 404 && url = find_redirect(path)
        # Issue a "Moved permanently" response with the redirect location
        [ 301, { "Location" => url }, [ "Redirecting..." ] ]
      else
        # Not a 404 or no redirect found, just send the response as is
        [ status, headers, body ]
      end
    end
    
    def find_redirect(url)
      redirect = Spree::Redirect.find_by_old_url(url)
      redirect.new_url unless redirect.nil?
    end
    
  end
end 
