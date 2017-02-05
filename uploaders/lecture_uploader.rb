class LectureUploader < CarrierWave::Uploader::Base
  storage :file

  def extension_whitelist
    %w(pdf)
  end

  def store_dir
    "uploads/lectures/#{model.id}"
  end

  def filename
    'lecture.pdf' if original_filename
  end
end
