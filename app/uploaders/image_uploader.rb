class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fit: [400, 400]


  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  #サムネイル用に画像をリサイズ
   version :thumb do
     process resize_to_fit: [100, 100]
   end

   version :thumb_c do
     process resize_to_fit: [70, 70]
   end

   version :thumb_liked do
     process resize_to_fit: [30, 30]
   end


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロード可能な拡張子のリスト
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
