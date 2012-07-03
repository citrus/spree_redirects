module SpreeRedirects
  class RedirectMiddleware
    
    def initialize(app)
      @app = app
    end
   
    def call(env)
      # when consider_all_requests_local is false, an exception is raised for 404
      # consider_all_requests_local should be false in a production environment

      begin
        status, headers, body = @app.call(env)
      rescue Exception => e
        routing_error = e
      end

      if routing_error.present? or status == 404
        path = [ env["PATH_INFO"], env["QUERY_STRING"] ].join("?").sub(/[\/\?\s]*$/, "").strip

        if url = find_redirect(path)
          # Issue a "Moved permanently" response with the redirect location
          return [ 301, { "Location" => url }, [ "Redirecting..." ] ]
        end
      end

      raise routing_error if routing_error.present?

      [ status, headers, body ]
    end
    
    def find_redirect(url)
      redirect = Spree::Redirect.find_by_old_url(url)
      redirect.new_url unless redirect.nil?
    end
    
  end
end 
