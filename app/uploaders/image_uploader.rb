require 'image_processing/mini_magick'

class ImageUploader < Shrine
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      thumbnail:  magick.resize_to_limit!(150, 150),
      nav: magick.resize_to_limit!(300, 300)
    }
  end
end
