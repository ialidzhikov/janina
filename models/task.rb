class Task < ActiveRecord::Base
  has_many :solutions

  def closed?
    deadline < Time.now.utc
  end
end
