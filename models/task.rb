class Task < ActiveRecord::Base
  def closed?
    deadline < ::DateTime.current
  end
end
