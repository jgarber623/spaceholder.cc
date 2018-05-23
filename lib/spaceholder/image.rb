module Spaceholder
  class Image
    def initialize(width, height)
      @width = width.to_i
      @height = (height || width).to_i
    end

    def process
      image.apply(
        resize_to_fill: [@width, @height],
        saver: {
          interlace: true,
          quality: 60,
          strip: true
        }
      ).call(save: false).write_to_buffer('.jpg')
    end

    private

    def image
      @image ||= ImageProcessing::Vips.source(image_paths.sample)
    end

    def image_paths
      @image_paths ||= Dir.glob(File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg'))
    end
  end
end
