require_relative '../uploaders/photo_uploader'

class User < ActiveRecord::Base
  scope :students, -> { where(admin: false) }

  has_secure_password
  has_many :solutions

  mount_uploader :photo, PhotoUploader

  validates :e_mail, presence: true

  def first_name
    full_name.split(' ').first
  end

  def points
    Solution.where(user_id: id).sum(:points)
  end
end
