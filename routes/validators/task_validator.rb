require_relative 'validator'

class TaskValidator
  include Validator

  FIELDS = {
    name: 'Name',
    description: 'Description',
    deadline: 'Deadline',
    max_points: 'Max points'
  }.freeze

  def valid?(params, flash)
    errors = []
    errors.concat validate_non_blank(FIELDS, params)

    if errors.any?
      flash.now[:error] = errors.first

      return false
    end

    true
  end
end
