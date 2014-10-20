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

        if redirect = Spree::Redirect.find_by_old_url(path)
          return [ redirect.status_code, { "Location" => redirect.new_url }, [ "Redirecting..." ] ]
        end

      end

      raise routing_error if routing_error.present?

      [ status, headers, body ]
    end

  end
end
