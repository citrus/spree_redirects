module SpreeRedirects
  class RedirectMiddleware
    
    def initialize(app)
      @app = app
    end
   
    def call(env)
      begin
        # when consider_all_requests_local is false, an exception is raised for 404
        status, headers, body = @app.call(env)
      rescue ActionController::RoutingError => e
        routing_error = e
      end

      if (routing_error.present? or status == 404)
        path = [ env["PATH_INFO"], env["QUERY_STRING"] ].join("?").sub(/[\/\?\s]*$/, "").strip

        if url = find_redirect(path)
          # Issue a "Moved permanently" response with the redirect location
          return [ 301, { "Location" => url }, [ "Redirecting..." ] ]
        end
      else
        raise routing_error unless Rails.configuration.consider_all_requests_local
      end

      [ status, headers, body ]
    end
    
    def find_redirect(url)
      redirect = Spree::Redirect.find_by_old_url(url)
      redirect.new_url unless redirect.nil?
    end
    
  end
end 
