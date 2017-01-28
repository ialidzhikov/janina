class User < ActiveRecord::Base
  has_secure_password

  validates :e_mail, presence: true
end
