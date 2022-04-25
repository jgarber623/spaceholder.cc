# frozen_string_literal: true

class Image
  SOURCE_PATHS = Dir.glob(File.expand_path('../assets/images/photos/*.jpg', __dir__)).freeze

  # @return [Integer]
  attr_reader :width

  # @return [Integer]
  attr_reader :height

  # @return [String]
  attr_reader :source

  # @param width [Integer]
  # @param height [Integer]
  def initialize(width, height)
    @width = Integer(width)
    @height = Integer(height)
    @source = SOURCE_PATHS.sample
  end

  # @return [Tempfile]
  def process
    ImageProcessing::MiniMagick
      .source(source)
      .resize_to_fill(width, height)
      .saver(interlace: 'Line', quality: 60, strip: true)
      .call
  end
end
