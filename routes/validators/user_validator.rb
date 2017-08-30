require_relative 'validator'

class UserValidator
  include Validator

  FIELDS = {
    full_name: 'Full name',
    faculty_number: 'Faculty number',
    e_mail: 'Email',
    password: 'Password',
    confirm_password: 'Confirm password'
  }.freeze

  def valid?(params, flash)
    errors = []
    errors.concat validate_non_blank(FIELDS, params)
    errors.concat validate_passwords(params)

    if errors.any?
      flash.now[:error] = errors.first

      return false
    end

    true
  end

  private

  def validate_passwords(params)
    password = params[:password]
    confirm_password = params[:confirm_password]
    password == confirm_password ? [] : ['Passwords do not match.']
  end
end
