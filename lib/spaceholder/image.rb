module Spaceholder
  class Image
    def initialize(width, height)
      @width = width.to_i
      @height = (height || width).to_i
    end

    def to_blob
      ImageProcessing::Vips.apply(
        resize_to_fill: [@width, @height],
        saver: {
          interlace: true,
          quality: 60,
          strip: true
        }
      ).call(image_paths.sample, save: false).write_to_buffer('.jpg')
    end

    private

    def image_paths
      @image_paths ||= Dir.glob(File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg'))
    end
  end
end
