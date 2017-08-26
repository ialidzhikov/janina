class Submission < ActiveRecord::Base
  belongs_to :solution

  has_many :comments, -> { order 'comments.id ASC' }
end
