module Spaceholder
  class Image
    def initialize(width, height)
      @width = width
      @height = height || width
    end

    def manipulate
      image.combine_options do |c|
        c.strip
        c.interlace 'plane'
        c.quality 60
        c.resize "#{dimensions}^"
        c.gravity 'center'
        c.crop "#{dimensions}+0+0"
      end
    end

    private

    def dimensions
      @dimensions ||= "#{@width}x#{@height}"
    end

    def image
      @image ||= MiniMagick::Image.open(Dir.glob(Library.image_paths).sample)
    end
  end
end
