class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  has_many :submissions, -> { order 'submissions.id ASC' }

  def code
    last_submission.code
  end

  def last_submission
    submissions.last
  end
end
