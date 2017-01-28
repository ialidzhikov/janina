class PhotoUploader < CarrierWave::Uploader::Base
  storage :file

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def default_url(*args)
    '/uploads/photos/default.png'
  end

  def store_dir
    "uploads/photos/#{model.faculty_number}"
  end

  def filename
    'photo.jpg' if original_filename
  end
end
