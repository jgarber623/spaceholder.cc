class Image
  IMAGE_LIBRARY_PATH = File.join(SpaceHolder.settings.root, 'app', 'assets', 'images', 'photos', '*.jpg')

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
    @image ||= MiniMagick::Image.open(image_paths.sample)
  end

  def image_paths
    @image_paths ||= Dir.glob(IMAGE_LIBRARY_PATH)
  end
end
