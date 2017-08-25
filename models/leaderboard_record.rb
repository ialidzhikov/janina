class LeaderboardRecord < ActiveRecord::Base
  def photo_url
    url = "/uploads/photos/#{faculty_number}/photo.jpg"
    if File.exist? "./public/#{url}"
      url
    else
      '/uploads/photos/default.png'
    end
  end
end
