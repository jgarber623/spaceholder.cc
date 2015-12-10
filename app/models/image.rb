class Image
  def initialize(dimensions)
    @image = MiniMagick::Image.open(Dir.glob('./app/assets/images/photos/*.jpg').sample)
    @dimensions = dimensions
  end

  def manipulate
    @image.strip

    @image.combine_options do |c|
      c.interlace 'plane'
      c.quality 60
      c.resize "#{@dimensions}^"
      c.gravity 'center'
      c.crop "#{@dimensions}+0+0"
    end
  end
end
