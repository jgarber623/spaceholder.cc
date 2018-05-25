module Spaceholder
  class Image
    OUTPUT_OPTIONS = {
      interlace: 'Line',
      quality: 60,
      strip: true
    }.freeze

    def initialize(width, height)
      @width = width.to_i
      @height = (height || width).to_i
    end

    def manipulate
      ImageProcessing::MiniMagick
        .source(image_paths.sample)
        .resize_to_fill(@width, @height)
        .saver(OUTPUT_OPTIONS)
        .call
    end

    private

    def image_paths
      @image_paths ||= Dir.glob(File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg'))
    end
  end
end
