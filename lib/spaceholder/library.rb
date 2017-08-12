module Spaceholder
  class Library
    def self.image_paths
      @image_paths ||= File.join(App.settings.root, 'assets', 'images', 'photos', '*.jpg')
    end
  end
end
