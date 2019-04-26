module Spaceholder
  module Image
    IMAGE_PATHS = Dir.glob(File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg')).freeze

    OUTPUT_OPTIONS = {
      interlace: 'Line',
      quality: 60,
      strip: true
    }.freeze

    def self.manipulate(width, height)
      ImageProcessing::MiniMagick
        .source(IMAGE_PATHS.sample)
        .resize_to_fill(width, height)
        .saver(OUTPUT_OPTIONS)
        .call
    end
  end
end
