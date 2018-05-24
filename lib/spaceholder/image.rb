module Spaceholder
  class Image
    def initialize(width, height)
      @width = width.to_i
      @height = (height || width).to_i
    end

    def to_blob
      tempfile = ImageProcessing::MiniMagick
        .source(image_paths.sample)
        .resize_to_fill(@width, @height)
        .saver(output_options)
        .call

      blob = tempfile.read

      tempfile.close
      tempfile.unlink

      blob
    end

    private

    def image_paths
      @image_paths ||= Dir.glob(File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg'))
    end

    def output_options
      @output_options ||= {
        interlace: 'Line',
        quality: 60,
        strip: true
      }
    end
  end
end
