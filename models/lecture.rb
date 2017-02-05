require_relative '../uploaders/lecture_uploader'

class Lecture < ActiveRecord::Base
  mount_uploader :content, LectureUploader
end
