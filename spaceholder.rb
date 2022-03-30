# frozen_string_literal: true

require_relative 'models/image'

class Spaceholder < Roda
  DIMENSION_REGEXP = /([1-4]?\d{1,3}|5000)/
  DIMENSIONS_REGEXP = /#{DIMENSION_REGEXP}(?:x#{DIMENSION_REGEXP})?/

  # Routing plugins
  plugin :public
  plugin :status_handler

  # Rendering plugins
  plugin :render

  # Request/Response plugins
  plugin :caching

  plugin :content_security_policy do |csp|
    csp.default_src :self
    csp.script_src :self, :unsafe_inline
    csp.style_src :self, :unsafe_inline, 'https://fonts.googleapis.com'
    csp.font_src :self, 'https://fonts.gstatic.com'
    csp.frame_ancestors :none
  end

  plugin :default_headers,
         'Content-Type' => 'text/html; charset=utf-8',
         'Strict-Transport-Security' => 'max-age=31536000; includeSubDomains; preload'

  # Other plugins
  plugin :environments
  plugin :heartbeat

  # Third-party plugins
  plugin :sprockets, debug: false, precompile: %w[application.css]

  configure do
    use Rack::Deflater
    # use Rack::Static, urls: ['/assets'], root: 'public'
  end

  route do |r|
    r.public
    r.sprockets unless opts[:environment] == 'production'

    r.root do
      response.cache_control public: true

      view :index
    end

    r.post '' do
      return view(:index) unless r.params.key?('width') && r.params.key?('height')

      r.redirect "/#{r.params['width']}x#{r.params['height']}"
    end

    r.get DIMENSIONS_REGEXP do |width, height|
      width = width.to_i
      height = (height || width).to_i

      return r.redirect '/' unless width.positive? && height.positive?

      begin
        image = Image.new(width, height).process

        response.cache_control public: true, max_age: 3600
        response['Content-Type'] = 'image/jpeg'
        response['X-Content-Type-Options'] = 'nosniff'

        response.write image.read
        response.finish
      ensure
        image.close!
      end
    end
  end

  status_handler(404) do
    response.cache_control public: true

    view :not_found
  end
end
