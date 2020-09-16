class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

    # process resize_to_fit: [50, 50]

    version :thumb do
      process :resize_to_fit => [50,50]
    end
end


# version :thumb do
#   process :resize_to_fit => [220, nil]
# end
