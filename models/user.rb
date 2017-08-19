require_relative '../uploaders/photo_uploader'

class User < ActiveRecord::Base
  has_secure_password
  has_many :solutions

  mount_uploader :photo, PhotoUploader

  validates :e_mail, presence: true
end
