class User < ActiveRecord::Base
  validates :e_mail, presence: true
end
