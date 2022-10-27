# frozen_string_literal: true

require_relative 'models/image'

class SpaceholderApp < Roda
  DIMENSION_REGEXP = /([1-3]?\d{1,3}|4000)/
  DIMENSIONS_REGEXP = /#{DIMENSION_REGEXP}(?:x#{DIMENSION_REGEXP})?/

  # Routing plugins
  plugin :head
  plugin :public
  plugin :status_handler

  # Rendering plugins
  plugin :render

  # Request/Response plugins
  plugin :caching

  plugin :content_security_policy do |csp|
    csp.base_uri :self
    csp.block_all_mixed_content
    csp.child_src :none
    csp.default_src :self
    csp.font_src :self, 'https://fonts.gstatic.com'
    csp.form_action :self
    csp.frame_ancestors :none
    csp.frame_src :none
    csp.img_src :self
    csp.media_src :self
    csp.object_src :none
    csp.script_src :self, :unsafe_inline
    csp.style_src :self, :unsafe_inline, 'https://fonts.googleapis.com'
    csp.worker_src :none
  end

  plugin :default_headers,
         'Content-Type' => 'text/html; charset=utf-8',
         'Referrer-Policy' => 'no-referrer-when-downgrade',
         'X-Frame-Options' => 'DENY',
         'X-XSS-Protection' => '0'

  # Other plugins
  plugin :environments
  plugin :heartbeat

  # Third-party plugins
  plugin :sprockets,
         css_compressor: :sassc,
         debug: false,
         precompile: %w[application.css spaceholder-180x180.png]

  configure do
    use Rack::CommonLogger
  end

  # :nocov:
  configure :production do
    use Rack::Deflater
    use Rack::HostRedirect, [ENV.fetch('HOSTNAME', nil), 'www.spaceholder.cc'].compact => 'spaceholder.cc'
    use Rack::Static, urls: ['/assets'], root: 'public'
  end
  # :nocov:

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
