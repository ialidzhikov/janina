class Task < ActiveRecord::Base
  has_many :solutions

  def closed?
    deadline < ::DateTime.current
  end
end
