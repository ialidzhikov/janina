module Validator
  def validate_non_blank(fields, params)
    fields.select { |key, _| params[key.to_s].blank? }
          .map { |_, value| "#{value} cannot be empty." }
  end
end
