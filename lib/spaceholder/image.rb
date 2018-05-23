module Spaceholder
  class Image
    def initialize(width, height)
      @width = width.to_i
      @height = (height || width).to_i
    end

    def to_blob
      data = processed_image.read

      processed_image.close
      processed_image.unlink

      data
    end

    private

    def image_paths
      @image_paths ||= Dir.glob(File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg'))
    end

    def processed_image
      ImageProcessing::Vips.apply(
        resize_to_fill: [@width, @height],
        saver: {
          interlace: true,
          quality: 60,
          strip: true
        }
      ).call(image_paths.sample)
    end
  end
end
