require_relative 'validator'

class LectureValidator
  include Validator

  FIELDS = {
    name: 'Name',
    content: 'Content',
    date: 'Date'
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
