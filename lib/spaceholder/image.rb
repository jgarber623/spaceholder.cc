module Spaceholder
  class Image
    def initialize(width, height)
      @width = width.to_i
      @height = (height || width).to_i
    end

    def to_blob
      ImageProcessing::Vips
        .source(image_paths.sample)
        .resize_to_fill(@width, @height)
        .call(save: false)
        .write_to_buffer('.jpg', output_options)
    end

    private

    def image_paths
      @image_paths ||= Dir.glob(File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg'))
    end

    def output_options
      @output_options ||= {
        interlace: true,
        Q: 60,
        strip: true
      }
    end
  end
end
